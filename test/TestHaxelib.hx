package;

import buddy.*;
using buddy.Should;

import Command;
import Config;


class TestHaxelib extends BuddySuite implements Buddy {

    public function new()
    {
        var getBin = function (command:Command) {
            return switch(command.cmd) {
                case bash(bin, args): bin;
                default: throw 'not a bash command';
            }
        };

        describe('Haxelib', function () {
            describe('#local', function () {
                it('should return commands to install haxelib locally', function () {
                    var commands = Haxelib.local(ConfigImpl.get(['minor']));
                    commands.length.should.be(3);
                    getBin(commands[0]).should.be('zip');
                });
            });

            describe('#submit', function () {
                it('should submit to haxelib', function () {
                    var commands = Haxelib.submit(ConfigImpl.get(['minor']));
                    commands.length.should.be(3);
                    getBin(commands[0]).should.be('zip');
                });
            });

            describe('#update', function () {
                it('should update the haxelib version', function () {
                    var haxelib = Haxelib.update(ConfigImpl.get(['minor']), {version: "0.1.0"});
                    var version:String = haxelib.version;
                    version.should.be('0.2.0');
                });
            });
        });
    }
}
