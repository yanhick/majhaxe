package;

import haxe.Json;

/**
 * Haxelib submission tool 
 */ 
class Main
{
    public static function main()
    {
        var args = Sys.args();

        //if the tool is run using haxelib, the last argument
        //will be the directory from which haxelib is called
        if (Sys.getEnv('HAXELIB_RUN') == '1')
        {
            Sys.setCwd(args.pop());
        }

        //if no args, display help
        if (args.length == 0)
        {
            usage();
            Sys.exit(0);
        }

        var haxelib = null;
        var config = null;

        try 
        {
            //parse args
            config = Config.get(args);

            //must have a haxelib conf file
            if (!sys.FileSystem.exists('haxelib.json')) 
                throw 'haxelib.json not found';

            haxelib = Json.parse(sys.io.File.getContent(Constants.HAXELIB_JSON));
            haxelib = Haxelib.update(config, haxelib);
        }
        catch (e:Dynamic)
        {
            error(e);
        }

        exec(config, haxelib);
    }

    /**
     * Execute IO if not a dry run. Print info for each command
     */
    static function exec(config:Config, haxelib:Dynamic)
    {
        Sys.println('saving the updated haxelib.json');
        if (!config.dryRun)
            sys.io.File.saveContent(Constants.HAXELIB_JSON, Json.stringify(haxelib));

        getCommands(config, haxelib).map(function (command) {
            Sys.println(command.info);
            if (!config.dryRun) {
                if (Sys.command(command.bin, command.args) != 0)
                    error(command.err);
            }
        });
    }

    /**
     * Print error and stop process
     */
    static function error(err:String)
    {
        Sys.println(err);
        Sys.exit(1);
    }

    /**
     * Return all the bash commands to execute
     */
    static function getCommands(config:Config, haxelib:Dynamic)
    {
        var commands = new Array<Command>();

        //commit in git
        if (!config.noCommit)
            commands = commands.concat(Git.commit(haxelib.version, config.comment));

        //push to git origin remote
        if (!config.noPush && !config.noCommit)
            commands = commands.concat(Git.push(config.remote));

        //submit to haxelib or install locally
        if (!config.local)
            commands = commands.concat(Haxelib.submit(config));
        else
            commands = commands.concat(Haxelib.local(config));

        return commands;
    }

   /**
    * display help
    */ 
    static function usage()
    {
        Sys.println('');
        Sys.println('MAJHAXE');
        Sys.println('Update semver version, commit and push to git and submit to haxelib');
        Sys.println('-------------------------------------------------');
        Sys.println('usage:');
        Sys.println('majhaxe [ <newversion> | major | minor | patch | build]');
        Sys.println('options:');
        Sys.println('  --m <optional message> - used as commit message and haxelib.json release note');
        Sys.println('  --no-commit - prevent commit the haxelib.json update to git');
        Sys.println('  --no-push - prevent pushing the haxelib.json commit and tag to the git remote');
        Sys.println('  --remote - an alternate remote to push to (defaults to origin)');
        Sys.println('  --exclude - a space separate list of files to exclude from the zip submitted to haxelib');
        Sys.println('  --local - install haxelib locally instead of submitting it');
        Sys.println('  --dry-run - print the commands that would be run without actually running them');
        Sys.println('');
    }
}
