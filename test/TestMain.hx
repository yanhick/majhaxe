package;

import buddy.*;
using buddy.Should;

import Command;


class TestMain extends BuddySuite implements Buddy {

    public function new()
    {
        var getBin = function (command:Command) {
            return switch(command.cmd) {
                case bash(bin, args): bin;
                default: throw 'not a bash command';
            }
        };

        describe('Config', function () {
            it('should create a config', function () {
                var config = Config.get(['minor']);
                config.semver.should.be('minor');
            });
        });

        describe('Haxelib', function () {
            describe('#local', function () {
                it('should return commands to install haxelib locally', function () {
                    var commands = Haxelib.local(Config.get(['minor']));
                    commands.length.should.be(3);
                    getBin(commands[0]).should.be('zip');
                });
            });

            describe('#submit', function () {
                it('should submit to haxelib', function () {
                    var commands = Haxelib.submit(Config.get(['minor']));
                    commands.length.should.be(3);
                    getBin(commands[0]).should.be('zip');
                });
            });

            describe('#update', function () {
                it('should update the haxelib version', function () {
                    var haxelib = Haxelib.update(Config.get(['minor']), {version: "0.1.0"});
                    var version:String = haxelib.version;
                    version.should.be('0.2.0');
                });
            });
        });
    }
}
