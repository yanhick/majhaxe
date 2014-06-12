package;

import buddy.*;
using buddy.Should;

import Command;


class TestGit extends BuddySuite implements Buddy {

    public function new()
    {
        var getBin = function (command:Command) {
            return switch(command.cmd) {
                case bash(bin, args): bin;
                default: throw 'not a bash command';
            }
        };

        describe('Git', function () {
            it('should return commands to commit to git', function () {
                var commands:Array<Command> = Git.commit('0.1.0', null);
                commands.length.should.be(3);
                getBin(commands[0]).should.be('git');
            });

            it('should return commands to push to git', function () {
                var commands = Git.push('origin');
                commands.length.should.be(2);
                getBin(commands[0]).should.be('git');
            });
        });
    }
}
