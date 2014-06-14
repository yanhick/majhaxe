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

        var io:IO = {
            output: Sys.println,
            input: function () return Sys.stdin().readLine(),
            read: sys.io.File.getContent,
            write: sys.io.File.saveContent
        };

        var config = Config.get(args.length == 0 ? args : args.slice(1));
        var command = getCommand(args.length == 0 ? '' : args[0], io, config);

        try {
            exec(command, config);
        }
        catch (e:Dynamic) {
            error(e);
        }
    }

    static function getCommand(arg:String, io:IO, config:Config)
    {
        return switch(arg) 
        {
            case 'submit': Submit.get.bind(config);
            default: Help.get.bind(io.output);
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
