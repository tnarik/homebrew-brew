class GitCafe < Formula
  desc "GIT Custom utility scripts by tnarik"
  homepage "https://github.com/tnarik/git_custom"
  url "https://github.com/tnarik/git_custom.git",
    using:    :git,
    revision: "185b396d19403fc899cc97264659d2bfb0da5367"
  version "0.0.3"

  bottle do
    root_url "https://ghcr.io/v2/tnarik/brew"
    rebuild 2
    sha256 cellar: :any_skip_relocation, catalina: "9bd26a7404d26111d3055b1a7bb975601fc926d7f807ae53c6a8f3543f6ff064"
  end

  # Could add depends_on "git", but let's not require the installation as git-cafe is more of a plugin
  depends_on "python"

  def install
    bin.install "git-all" => "git-all"
    bin.install "git-create" => "git-create"
    bin.install "git-cafelist" => "git-cafelist"
    bin.install "git-bkup" => "git-bkup"
  end

  test do
    assert_match("info, do it right", shell_output("#{bin}/git-all", 127))
    assert_match(/Creates a repository.*/, shell_output("#{bin}/git-create", 127))
    assert_match(/List all repos.*/, shell_output("#{bin}/git-cafelist -h", 127))
    assert_match(/usage: git-bkup .*/, shell_output("#{bin}/git-bkup -h"))
  end
end
