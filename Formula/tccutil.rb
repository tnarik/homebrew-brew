class Tccutil < Formula
  include Language::Python::Shebang

  desc "Utility to modify the macOS Accessibility Database (TCC.db)"
  homepage "https://github.com/tnarik/tccutil"
  url "https://github.com/tnarik/tccutil/archive/refs/tags/v1.4.0.tar.gz"
  sha256 "45047b0eadf1a520cba634542d1402243bdd666bb507650513aef3896e463a5f"
  license "GPL-2.0-or-later"
  head "https://github.com/tnarik/tccutil.git", branch: "main"

  bottle do
    root_url "https://ghcr.io/v2/tnarik/brew"
    sha256 cellar: :any_skip_relocation, all: "6de7343a59d8cc022a3454d7647d69848fe772ee03b9f1c380c5dfe40b119163"
  end

  depends_on :macos
  depends_on "python-packaging"
  depends_on "python@3.12"

  def python3
    which("python3.12")
  end

  def install
    rewrite_shebang detected_python_shebang, "tccutil.py"
    bin.install "tccutil.py" => "tccutil"
  end

  test do
    assert_match "Unrecognized command check", shell_output("#{bin}/tccutil check 2>&1")
    assert_match "tccutil #{version}", shell_output("#{bin}/tccutil --version")
  end
end
