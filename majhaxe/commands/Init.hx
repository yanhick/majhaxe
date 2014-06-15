package commands;

import Command;
import Resources;
import UserInput;

/**
 * Init a new Haxe project
 */
class Init
{
    public static function get(config:Config, io:IO, resources:Resources, getInput:Void->InitInput):Array<Command>
    {
        var input = getInput();
        var commands = [Git.init()];

        commands.push({
            info: 'creating a '+ input.license + ' license file',
            err: 'could not create a' + input.license + ' license file',
            cmd: func(function () {
                io.write('license.md', resources.createMIT(Date.now().getFullYear(), input.holder));
            })
        });

        commands.push({
            info: 'creating a travis file',
            err: 'could not create a travis file',
            cmd: func(function () {
                io.write('.travis.yml', resources.createTravis(input.dependencies, 'haxe build.hxml'));
            })
        });

        commands.push({
            info: 'creating a main haxe file',
            err: 'could not create a main haxe file',
            cmd: func(function () {
                io.write(input.source + '/Main.hx', resources.createMain(input.project));
            })
        });

        commands.push({
            info: 'creating a readme file',
            err: 'could not create a readme file',
            cmd: func(function () {
                io.write('readme.md', resources.createReadme(input.project, input.description));
            })
        });

        commands.push({
            info: 'creating an hxml file',
            err: 'could not create an hxml file',
            cmd: func(function () {
                io.write('build.hxml', resources.createHXML(input.targets, input.dependencies, input.project));
            })
        });


        return commands;
    }
}

