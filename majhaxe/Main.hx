package;

import haxe.Json;
import commands.*;

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

        var command = 
        if (args.length == 0) Help.get
        else getCommand(args.shift());

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

        exec(command.bind(config, haxelib), config, haxelib);
    }

    static function getCommand(arg:String)
    {
        return switch(arg) 
        {
            case 'submit': Submit.get;
            default: Help.get;
        };
    }

    /**
     * Execute IO if not a dry run. Print info for each command
     */
    static function exec(command:Void->Array<Command>, config:Config, haxelib:Dynamic)
    {
        Sys.println('saving the updated haxelib.json');
        if (!config.dryRun)
            sys.io.File.saveContent(Constants.HAXELIB_JSON, Json.stringify(haxelib));

        command().map(function (command) {
            Sys.println(command.info);
            switch(command.cmd) 
            {
                case bash(bin, args):
                    if (!config.dryRun) {
                        if (Sys.command(bin, args) != 0)
                            error(command.err);
                    }
                case func(fn): fn();
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
}
