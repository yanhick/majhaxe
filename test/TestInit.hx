package;

import buddy.*;
using buddy.Should;

import Command;
import commands.Init;


class TestInit extends BuddySuite implements Buddy {

    public function new()
    {
        describe('Init', function () {
            it('should create a full project', function () {

                var commands = Init.get(Config.get([]), {
                    input: function () return '',
                    output: function (str){},
                    read: function (content) return '',
                    write: function (path, content){}
                });

                (switch(commands[0].cmd) {
                    case bash('git', ['init']): true;
                    case _: false;
                }).should.be(true);

            });
        });
    }
}
