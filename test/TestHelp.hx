package;

import buddy.*;
using buddy.Should;

import commands.Help;
import Command;

class TestHelp extends BuddySuite implements Buddy {

    public function new()
    {
        describe('Help', function () {
            it('should print help', function (done) {

                var output = function (out:String) {
                    out.indexOf('usage').should.not.be(-1);
                    done();
                };
                
                (switch(Help.get(output)[0].cmd) {
                    case func(fn):
                        fn();
                        true;
                    case _: false;

                }).should.be(true);
            });
        });
    }
}
