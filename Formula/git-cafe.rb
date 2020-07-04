class GitCafe < Formula
  desc "GIT Custom utils by tnarik"
  homepage "https://gogs.lecafeautomatique.net/tnarik/git_custom"
  url "git@gitcafe:tnarik/git_custom.git",
    :using    => :git,
    :revision => "419e001af9"
  version "0.0.2"

  bottle do
    root_url "https://dl.bintray.com/tnarik/bottles-brew"
    cellar :any_skip_relocation
    rebuild 1
    sha256 "dd4b879f58db1aebc85566be71e3163bccdede20e29ac7043a28b04fbecdf6ea" => :catalina
  end

  # Could add depends_on "git", but let's not require the installation as git-cafe is more of a plugin

  def install
    bin.install "git-all" => "git-all"
    bin.install "git-create" => "git-create"
    bin.install "git-cafelist" => "git-cafelist"
  end

  test do
    assert_match "info, do it right", shell_output("#{bin}/git-all", 127)
    assert_match /Creates a repository.*/, shell_output("#{bin}/git-create", 127)
    assert_match /List all repos.*/, shell_output("#{bin}/git-cafelist -h", 127)
  end
end
