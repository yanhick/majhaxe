[![Build Status](https://travis-ci.org/yanhick/majhaxe.svg?branch=master)](https://travis-ci.org/yanhick/majhaxe)
majhaxe
=========

CLI tool to kick some Haxe

######Linux/MacOS only

###Install

```
haxelib install majhaxe
```

You can then run it with:

```
haxelib run majhaxe
```

That’s pretty long ! We’d better alias it:

```
echo “alias majhaxe=’haxelib run majhaxe’” >> ~/.bashrc && source ~/.bashrc
```

The rest of this file assums you aliased majhaxe.

###Usage

####Submit

Update semver version, commit and push to git and submit to haxelib

```
majhaxe submit [ <newversion> | major | minor | patch | build]
```

```
--m <optional message> //used as commit message and haxelib.json release note
--no-commit //prevent commit the haxelib.json update to git
--no-push //prevent pushing the haxelib.json commit and tag to the git remote
--remote //an alternate remote to push to (defaults to origin)
--exclude //a space separate list of files to exclude from the zip submitted to haxelib
--dry-run //print the commands that would be run without actually running them
```

####Init

Init an Haxe project.
Specifically:
* init a git repo
* create an .hxml file
* create an haxelib.json
* create a travis.yaml file
* create a readme.md
* create a Haxe Main class

```
majhaxe init
```

```
--no-git //prevent the creation of a git repo
--dry-run //print the commands that would be run without actually running them
```

####Local

Install the haxelib locally

```
majhaxe local
```

```
--exclude //a space separate list of files to exclude from the zip installed locally
--dry-run //print the commands that would be run without actually running them
```
####Install

Install all haxelib dependencies listed in haxelib.json

```
majhaxe install
```

###Build

```
make
```

###Test

```
make run-test
```
