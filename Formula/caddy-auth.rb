class CaddyAuth < Formula
  desc "Powerful, enterprise-ready, open source web server with automatic HTTPS (with custom plugins)"
  homepage "https://caddyserver.com/"
  url "https://github.com/caddyserver/caddy/archive/v2.4.4.tar.gz"
  sha256 "0ea7b65406c77b2ce88cdf496e82b70838c78305659fa5c891ef004dfabcc17a"
  license "Apache-2.0"
  head "https://github.com/caddyserver/caddy.git", branch: "master"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "1f4dd7deb1ee1c337d8bee3e91c522ada5f86bd677113079ff6ce087c915e581"
    sha256 cellar: :any_skip_relocation, big_sur:       "931f9b62c50c28f28b930bdfd830323834260ad397d78bbdf3609d220dc60bf3"
    sha256 cellar: :any_skip_relocation, catalina:      "931f9b62c50c28f28b930bdfd830323834260ad397d78bbdf3609d220dc60bf3"
    sha256 cellar: :any_skip_relocation, mojave:        "931f9b62c50c28f28b930bdfd830323834260ad397d78bbdf3609d220dc60bf3"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "8c0bef614ad308b3828c08b74e04f5605a4add5d85904443c13f632ad9007908"
  end

  depends_on "go" => :build

  resource "xcaddy" do
    url "https://github.com/caddyserver/xcaddy/archive/v0.1.9.tar.gz"
    sha256 "399880f59bf093394088cf2d802b19e666377aea563b7ada5001624c489b62c9"
  end

  def install
    revision = build.head? ? version.commit : "v#{version}"

    resource("xcaddy").stage do
      system "go", "run", "cmd/xcaddy/main.go", "build", revision, \
        "--with", "github.com/greenpau/caddy-auth-jwt", \
        "--with", "github.com/greenpau/caddy-auth-portal", \
        "--with", "github.com/greenpau/caddy-trace", \
        "--output", bin/"caddy"
    end
  end

  service do
    run [opt_bin/"caddy", "run", "--config", etc/"Caddyfile"]
    keep_alive true
    error_log_path var/"log/caddy.log"
    log_path var/"log/caddy.log"
  end

  test do
    port1 = free_port
    port2 = free_port

    (testpath/"Caddyfile").write <<~EOS
      {
        admin 127.0.0.1:#{port1}
      }
      http://127.0.0.1:#{port2} {
        respond "Hello, Caddy!"
      }
    EOS

    fork do
      exec bin/"caddy", "run", "--config", testpath/"Caddyfile"
    end
    sleep 2

    assert_match "\":#{port2}\"",
      shell_output("curl -s http://127.0.0.1:#{port1}/config/apps/http/servers/srv0/listen/0")
    assert_match "Hello, Caddy!", shell_output("curl -s http://127.0.0.1:#{port2}")

    assert_match version.to_s, shell_output("#{bin}/caddy version")
  end
end
