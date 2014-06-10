package commands;

import Command;

/**
 * Display help
 */
class Help
{
    public static function get(config:Config, haxelib:Dynamic):Array<Command>
    {
        return [{
            cmd: func(Sys.println.bind(usage())),
            err: 'could not display help',
            info: ''
        }];
    }

    static function usage()
    {
        return 
'MAJHAXE
Update semver version, commit and push to git and submit to haxelib
-------------------------------------------------
usage:
majhaxe [ <newversion> | major | minor | patch | build]
options:
  --m <optional message> - used as commit message and haxelib.json release note
  --no-commit - prevent commit the haxelib.json update to git
  --no-push - prevent pushing the haxelib.json commit and tag to the git remote
  --remote - an alternate remote to push to (defaults to origin)
  --exclude - a space separate list of files to exclude from the zip submitted to haxelib
  --local - install haxelib locally instead of submitting it
  --dry-run - print the commands that would be run without actually running them';
    }
}

