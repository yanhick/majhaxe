package;

import buddy.*;
using buddy.Should;

import commands.Submit;
import Config;
using Lambda;

class TestSubmit extends BuddySuite implements Buddy {
    public function new() {
        describe('submit', function () {

            describe('#submit', function () {

                it('should return commands to submit to haxelib', function () {

                    var io:IO = {
                        input: function () return 'user input',
                        output: function (str) {},

                        write: function (path, content) {
                            path.should.be(Constants.HAXELIB_JSON);
                            content.should.be('{
 "version": "1.0.1"
}');
                        },
                        read: function (path) {
                            path.should.be(Constants.HAXELIB_JSON);
                            return '{"version": "1.0.0"}';
                        }, 
                        exists: function (path) {
                            path.should.be(Constants.HAXELIB_JSON);
                            return true;
                        }
                    }

                    var commands = Submit.get(ConfigImpl.get(['patch']), io);
                    commands.foreach(function (command) {
                        return switch(command.cmd) {
                            case func(fn):
                                fn(); 
                                true;
                            case bash(_, _): true;
                            case _: false;
                        }
                    }).should.be(true);

                });
            });
        });
    }

}

