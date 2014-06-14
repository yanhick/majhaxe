package commands; 
import Command;
import Resources;

/**
 * Init a new Haxe project
 */
class Init
{
    public static function get(config:Config, io:IO):Array<Command>
    {
        var resources = ResourcesImpl.get();
        var input = UserInput.init(io.output, io.input);

        var commands = [Git.init()];

        commands.push({
            info: 'creating a licence file',
            err: 'could not create a licence file',
            cmd: func(function () {
                io.write('licence.md', resources.createMIT(Date.now().getFullYear(), input.holder));
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
                io.write('.travis.yml', resources.createMain(input.project));
            })
        });


        return commands;
    }
}

