package;

/**
 * Haxelib submission tool 
 */ 
class Main
{
    public static function main()
    {
        //if no args, display help
        if (Sys.args().length == 0)
        {
            usage();
            Sys.exit(0);
        }

        //must have a haxelib conf file
        if (!sys.FileSystem.exists('haxelib.json')) 
            Utils.error('haxelib.json not found');

        //parse args
        var config = Config.get(Sys.args());

        //update semver
        var updatedVersion = Haxelib.update(config);

        //commit in git
        if (!config.noCommit)
            Git.commit(updatedVersion, config.comment);

        //push to git origin remote
        if (!config.noPush && !config.noCommit)
            Git.push(config.remote);

        //submit to haxelib or install locally
        if (!config.local)
            Haxelib.submit(config);
        else
            Haxelib.local(config);
    }

   /**
    * display help
    */ 
    static function usage()
    {
        Sys.println('');
        Sys.println('HX-SUBMIT');
        Sys.println('Update semver version, commit and push to git and submit to haxelib');
        Sys.println('-------------------------------------------------');
        Sys.println('usage:');
        Sys.println('hx-submit [ <newversion> | major | minor | patch | build]');
        Sys.println('options:');
        Sys.println('  --m <optional message> - used as commit message and haxelib.json release note');
        Sys.println('  --no-commit - prevent commit the haxelib.json update to git');
        Sys.println('  --no-push - prevent pushing the haxelib.json commit and tag to the git remote');
        Sys.println('  --remote - an alternate remote to push to (defaults to origin)');
        Sys.println('  --exclude - a space separate list of files to exclude from the zip submitted to haxelib');
        Sys.println('  --local - install haxelib locally instead of submitting it');
        Sys.println('');
    }
}
