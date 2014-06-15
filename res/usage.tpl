MAJHAXE
CLI tool to kick some Haxe
-------------------------------------------------
usage:

submit [ <newversion> | major | minor | patch | build]
Update semver version, commit and push to git and submit to haxelib

options:
  --m <optional message> - used as commit message and haxelib.json release note
  --no-commit - prevent commit the haxelib.json update to git
  --no-push - prevent pushing the haxelib.json commit and tag to the git remote
  --remote - an alternate remote to push to (defaults to origin)
  --exclude - a space separate list of files to exclude from the zip submitted to haxelib
  --local - install haxelib locally instead of submitting it
  --dry-run - print the commands that would be run without actually running them

init
Init an Haxe project

options:
    --no-git - prevent the creation of a git repo
    --dry-run - print the commands that would be run without actually running them
