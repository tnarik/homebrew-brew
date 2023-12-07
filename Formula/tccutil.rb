class Tccutil < Formula
  include Language::Python::Shebang

  desc "Utility to modify the macOS Accessibility Database (TCC.db)"
  homepage "https://github.com/tnarik/tccutil"
  url "https://github.com/tnarik/tccutil/archive/refs/tags/v1.4.0.tar.gz"
  sha256 "7f3e52a2a9cb662182972ddc851d86ec8839b4c498c0e4445a3c53836e7ff2aa"
  license "GPL-2.0-or-later"
  head "https://github.com/tnarik/tccutil.git", branch: "main"

  bottle do
    root_url "https://ghcr.io/v2/tnarik/brew"
    sha256 cellar: :any_skip_relocation, all: "b19dad5f5b3fa2d3690d79379b7f2704b052dd2e09d34592ff224d8ed4bf422e"
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
    assert_match "Unrecognized command \"check\"", shell_output("#{bin}/tccutil check 2>&1")
    assert_match "tccutil #{version}", shell_output("#{bin}/tccutil --version")
  end
end
