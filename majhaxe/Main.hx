package;

import haxe.Json;
import commands.*;

import Resources;
import UserInput;
import IO;

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

        var config = Config.get(args.length == 0 ? args : args.slice(1));
        var io = IOImpl.get(config.dryRun);
        var getInitInput = function () return UserInput.init(io.output, io.input);
        var resources = ResourcesImpl.get();

        var command = getCommand(args.length == 0 ? '' : args[0], io, config, resources, getInitInput);

        try {
            exec(command, config);
        }
        catch (e:Dynamic) {
            error(e);
        }
    }

    static function getCommand(arg:String, io:IO, config:Config, resources:Resources, getInitInput:Void->InitInput)
    {
        return switch(arg) 
        {
            case 'submit': Submit.get.bind(config, io);
            case 'init': Init.get.bind(config, io, resources, getInitInput);
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
