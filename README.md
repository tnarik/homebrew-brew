# Tnarik Brew

## How do I install these formulae?
`brew install tnarik/brew/<formula>`

Or `brew tap tnarik/brew` and then `brew install <formula>`.

Or install via URL (which will not receive updates):

```
brew install https://raw.githubusercontent.com/tnarik/homebrew-brew/master/Formula/<formula>.rb
```

## Documentation
`brew help`, `man brew` or check [Homebrew's documentation](https://docs.brew.sh).


The tap was created via:

```
brew tap-new tnarik/brew
cd $(brew --repo  tnarik/brew)
```

There you can work on the formulae, starting by the creation based on a template:

```
brew create --tap=tnarik/brew <URL to zipl or tarball>
```

More information is available [here](https://docs.brew.sh/Formula-Cookbook)

It is a good idea to add some tests after the creation of the formulae and any modification (and remove all generated comments). In order to test:

```
brew test git-cafe
```

## Development

After editing, run:

* `brew audit --strict --online <formula>` (this must be used for formulae submitted to Homebrew)
* `brew audit --new-formula <formula>`

Commits, branches, etc... can be run from the tap created (no need to clone outside of Homebrew).

Running `brew test-bot --tap=tnarik/brew <formula>` would test and analyze the formula <formula> and create a bottle based on the OS/architecture used for running the process.

## Notes
Even though the installation of some tools/applications starts from private repos, it makes sense distributing what is basically source code (scripts) as a bottle as well just in case someone else actually wants to use them.

As the git-cafe repo is private, it means building from source might break (on a CI pipeline or some machines) until I finally manage to find the time to migrate the code to public repos. Therefore I'm creating and uploading bottles manually from my local installation.

Bintray used to be supported (I followed some information [here](https://jonathanchang.org/blog/maintain-your-own-homebrew-repository-with-binary-bottles/)), but as of 2021 it shuthdown and the process is slightly different.

Until a migration to a public repo, a bottle can be created via:

1. either:
  * `brew install --build-bottle <formula path>` to prepare the package
  * `brew bottle --root-url=https://ghcr.io/v2/tnarik/brew --json <formula>` to generate the bottle
  * followed by `brew bottle --merge --write --no-commit <JSON FILE CREATED>` to merge the bottle info
2. or `brew test-bot --root-url=https://ghcr.io/v2/tnarik/brew --tap=tnarik/brew <formula>` to do all the above plus run checks.

Then it can be uploaded to GitHub Packages, which requires the configuration of:

```
export HOMEBREW_GITHUB_PACKAGES_USER=<YOUR_USER>
export HOMEBREW_GITHUB_PACKAGES_TOKEN=<YOUR_PERSONAL_ACCESS_TOKEN>
```

`<YOUR_PERSONAL_ACCESS_TOKEN>` is created via `GitHub > Settings > Developer Settings > Personal access tokens`. The following scopes should be granted:

* `write:packages`

Use `brew pr-upload --upload-only --root-url=https://ghcr.io/v2/<tap>`, where `<tap>` is in this case `tnarik/brew`.

It essentially uses the GitHub Packages (Docker Container Registry), with an artifact domain of `tnarik/brew`.

**note**: an alternative is to handle the upload of the binaries and editing of recipes manually.

**note**: as the default visibility of a package is `private`, it should be changed to `public` via GitHub. There seems to be a way of allowing the download of private packages via a proxy such as JFrog Artifactory or by adding a Custom Download Strategy to the tap and the formulae requiring it, but it is a bit of an overkill for what I'm trying to do (would like to find out how to do so, but the package tools are nothing fancy, even if the source is kept in my own repos).

~~There is some information [here](https://docs.brew.sh/Python-for-Formula-Authors) regarding Python related formulae.~~
