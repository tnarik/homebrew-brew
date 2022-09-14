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
Even though the installation of some tools/applications starts from private repos, it makes sense distributing what is basically source code (scripts) as a bottle as well just in case someone else actually wants to use them. Found some information [here](https://jonathanchang.org/blog/maintain-your-own-homebrew-repository-with-binary-bottles/), but as of 2021 Bintray has been shutdown and the process doesn't work that way.

That means in some instances building from source might break until I finally manage to find the time to migrate the code to public repos.

~~Bottles will be uploaded to bintray, which is free for open source projects. I'm not sure if it is a restriction, but it is a good idea to have the name of the repository starting with `bottles` and it doesn't hurt if `bottles-<tap>` matches `homebrew-<tap>`.~~
~~Other than that (and optionally selecting a OSS license for the whole repo), a package need to be created, matching the name of the different formulae. The OSS license can be selected at that point.~~

~~The following would run locally the test-bot flow for the formula, creating the bottles.~~

```
#brew test-bot --root-url=https://dl.bintray.com/tnarik/bottles-brew --bintray-org=tnarik --tap=tnarik/brew <formula>
```

~~And this would upload the bottles (`HOMEBREW_BINTRAY_USER` and `HOMEBREW_BINTRAY_KEY` need to be defined):~~

```
#brew pr-upload --bintray-org=tnarik --root-url=https://dl.bintray.com/tnarik/bottles-brew
```

~~It can be used with `--no-publish` in case checking and manual publishing is desired (they will be uploaded, but kept private for some time until they expire if not published).~~

~~There is some information [here](https://docs.brew.sh/Python-for-Formula-Authors) regarding Python related formulae.~~
