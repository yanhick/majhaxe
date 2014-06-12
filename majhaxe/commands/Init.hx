package commands; 
import Command;

/**
 * Init a new Haxe project
 */
class Init
{
    public static function get(config:Config, io:IO):Array<Command>
    {
        var input = UserInput.init(io.output, io.input);

        var commands = [Git.init()];

        commands.push({
            info: 'creating a licence file',
            err: 'could not create a licence file',
            cmd: func(function () {
                io.write('licence.md', Resources.createMIT(Date.now().getFullYear(), input.holder));
            })
        });

        commands.push({
            info: 'creating a travis file',
            err: 'could not create a travis file',
            cmd: func(function () {
                io.write('.travis.yml', Resources.createTravis(input.dependencies, 'haxe build.hxml'));
            })
        });

        commands.push({
            info: 'creating a main haxe file',
            err: 'could not create a main haxe file',
            cmd: func(function () {
                io.write('.travis.yml', Resources.createMain(input.project));
            })
        });


        return commands;
    }
}

