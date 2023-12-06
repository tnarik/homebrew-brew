class Tccutil < Formula
  include Language::Python::Shebang

  desc "Utility to modify the macOS Accessibility Database (TCC.db)"
  homepage "https://github.com/tnarik/tccutil"
  url "https://github.com/tnarik/tccutil/archive/refs/tags/v1.4.0.tar.gz"
  sha256 "af799a69a32b5d0a9b7eeca2722136d4bc2906a6567a30e1ff8bef855b871c96"
  license "GPL-2.0-or-later"
  head "https://github.com/tnarik/tccutil.git", branch: "main"

  bottle do
    root_url "https://ghcr.io/v2/tnarik/brew"
    sha256 cellar: :any_skip_relocation, all: "299559f24abe2ce4c1156897c3f4304ac37f669eeb51a179aa46d3ae93cf901c"
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
