class CaddyAuth < Formula
  desc "Powerful, enterprise-ready, OSS web server with automatic HTTPS (customized)"
  homepage "https://caddyserver.com/"
  url "https://github.com/caddyserver/caddy/archive/refs/tags/v2.7.5.tar.gz"
  sha256 "eeaecc1ea18b7aa37ece168562beb1ab592767cbedfaa411040ae0301aaeeef1"
  license "Apache-2.0"
  head "https://github.com/caddyserver/caddy.git", branch: "master"

  bottle do
    rebuild 1
    sha256 cellar: :any_skip_relocation, catalina: "602eb1542bfee701e114ffa662ffece95fc3c5dfebcf6796d58a1209789cd00b"
  end

  depends_on "go" => :build

  resource "xcaddy" do
    url "https://github.com/caddyserver/xcaddy/archive/refs/tags/v0.3.5.tar.gz"
    sha256 "41188931a3346787f9f4bc9b0f57db1ba59ab228113dcf0c91382e40960ee783"
  end

  def install
    revision = build.head? ? version.commit : "v#{version}"

    resource("xcaddy").stage do
      system "go", "run", "cmd/xcaddy/main.go", "build", revision, \
        "--with", "github.com/greenpau/caddy-security", \
        "--with", "github.com/greenpau/caddy-trace", \
        "--output", bin/"caddy"
    end

    generate_completions_from_executable("go", "run", "cmd/caddy/main.go", "completion")
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
