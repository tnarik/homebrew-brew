class GitCafe < Formula
  desc "GIT utils by tnarik"
  homepage "https://gogs.lecafeautomatique.net/tnarik/git_custom"
  url "git@gitcafe:tnarik/git_custom.git",
    :using    => :git,
    :revision => "a0cab7608c5805fd2f55d25477a54083e28eeb71"
  version "0.0.1"

  bottle do
    root_url "https://dl.bintray.com/tnarik/bottles-tap"
    cellar :any_skip_relocation
    sha256 "56054df145fa307eb5170ad5b2fbe9def6ef53615fea95f43202079cc051736a" => :catalina
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
