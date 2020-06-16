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

It is a good idea to add some tests after the creatoin of the formulae are edited (and remove all generated comments). In order to test:

```
brew test git-cafe
```

## Notes
Even though the installation of some tools/applications starts from private repos, it makes sense distributing what is basically source code (scripts) as a bottle as well just in case someone else actually wants to use them.

That means in some instances building from source might break until I finally manage to find the time to migrate the code to public repos.
