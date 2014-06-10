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

        var config = Config.get(args);
        try {
            exec(command.bind(Config.get(args)), config);
        }
        catch (e:Dynamic) {
            error(e);
        }
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
     * Execute all IO commands if not a dry run. Print info and/or error for each command
     */
    static function exec(command:Void->Array<Command>, config:Config)
    {
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
