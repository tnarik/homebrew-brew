class CaddyAuth < Formula
  desc "Powerful, enterprise-ready, OSS web server with automatic HTTPS (customized)"
  homepage "https://caddyserver.com/"
  url "https://github.com/caddyserver/caddy/archive/v2.4.4.tar.gz"
  sha256 "0ea7b65406c77b2ce88cdf496e82b70838c78305659fa5c891ef004dfabcc17a"
  license "Apache-2.0"
  head "https://github.com/caddyserver/caddy.git", branch: "master"

  bottle do
    rebuild 1
    sha256 cellar: :any_skip_relocation, catalina: "602eb1542bfee701e114ffa662ffece95fc3c5dfebcf6796d58a1209789cd00b"
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

    assert_match("\":#{port2}\"",
      shell_output("curl -s http://127.0.0.1:#{port1}/config/apps/http/servers/srv0/listen/0"))
    assert_match("Hello, Caddy!", shell_output("curl -s http://127.0.0.1:#{port2}"))

    assert_match(version.to_s, shell_output("#{bin}/caddy version"))
  end
end
