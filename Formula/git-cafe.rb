class GitCafe < Formula
  desc "GIT Custom utils by tnarik"
  homepage "https://gogs.lecafeautomatique.net/tnarik/git_custom"
  url "git@gitcafe:tnarik/git_custom.git",
    using:    :git,
    revision: "a0bbe10c2721f97737c7106daa57c652903e0a1b"
  version "0.0.3"

  bottle do
    root_url "https://github.com/tnarik/homebrew-brew/releases/download/git-cafe-0.0.3"
    rebuild 2
    sha256 cellar: :any_skip_relocation, catalina: "6f027d6264591432f76d8b25cd8c235688f037b10b15b4deda9de7633544668f"
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
