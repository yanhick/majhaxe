package;

import buddy.*;
using buddy.Should;

import Command;
import commands.Init;

class TestInit extends BuddySuite implements Buddy {

    public function new()
    {
        describe('Init', function () {
            var io = {
                input: function () return '',
                output: function (str){},
                read: function (content) return '',
                write: function (path, content){}
            };
            it('should create a git repo', function () {

                var commands = Init.get(Config.get([]), io);

                (switch(commands[0].cmd) {
                    case bash('git', ['init']): true;
                    case _: false;
                }).should.be(true);

                (switch(commands[1].cmd) {
                    case func(fn): true;
                    case _: false;
                }).should.be(true);
            });
        });
    }
}
