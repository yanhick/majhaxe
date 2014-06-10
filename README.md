[![Build Status](https://travis-ci.org/yanhick/majhaxe?branch=master)](https://travis-ci.org/yanhick/majhaxe)
majhaxe
=========

Neko tool to update haxelibs.
- update the semver version
- commit and push to git
- submit to haxelib

######Linux/MacOS only

###Install

```
haxelib install majhaxe
```



###Usage

```
haxelib run majhaxe [ <newversion> | major | minor | patch | build]
```

###Additional options

```
--m <optional message> //used as commit message and haxelib.json release note
--no-commit //prevent commit the haxelib.json update to git
--no-push //prevent pushing the haxelib.json commit and tag to the git remote
--remote //an alternate remote to push to (defaults to origin)
--exclude //a space separate list of files to exclude from the zip submitted to haxelib
--local //install haxelib locally instead of submitting it
--dry-run //print the commands that would be run without actually running them
```

###Build

```
make
```

###Test

```
make run-tests
```
