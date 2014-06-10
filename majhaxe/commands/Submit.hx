package commands;

import haxe.Json;


/**
 * Submit to haxelib
 */
class Submit
{
    public static function get(config:Config, haxelib:Dynamic):Array<Command>
    {
        //must have a haxelib conf file
        if (!sys.FileSystem.exists('haxelib.json')) 
            return throw 'haxelib.json not found';

        if (config.semver == null)
            return throw 'first argument need to be a valid semver';

        var commands = new Array<Command>();

        commands.push({
            info: 'saving the updated haxelib.json',
            err: 'could not save updated haxelib.json',
            cmd: func(function () {
                if (!config.dryRun)
                    sys.io.File.saveContent(Constants.HAXELIB_JSON, Json.stringify(haxelib));
            })});

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
}

