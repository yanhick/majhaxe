package;

import buddy.*;
using buddy.Should;


class TestMain extends BuddySuite implements Buddy {

    public function new()
    {
        describe('Git', function () {
            it('should return commands to commit to git', function () {
                var commands = Git.commit('0.1.0', null);
                switch(commands[0]) {
                    case bash(value):
                        value.bin.should.be('git');
                        value.args.length.should.be(2);
                    default:
                }
            });

            it('should return commands to push to git', function () {
                var commands = Git.push('origin');
                switch(commands[0]) {
                    case bash(value):
                        value.bin.should.be('git');
                        value.args[0].should.be('push');
                        value.args[1].should.be('origin');
                    default:
                }
            });
        });

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
                    switch(commands[0]) {
                        case bash(value):
                            value.bin.should.be('zip');
                        default:
                            
                    }
                    switch(commands[1]) {
                        case bash(value):
                            value.bin.should.be('haxelib');
                        default:
                    }
                });
            });

            describe('#submit', function () {
                it('should submit to haxelib', function () {
                    var commands = Haxelib.submit(Config.get(['minor']));
                    switch(commands[0]) {
                        case bash(value):
                            value.bin.should.be('zip');
                        default:
                            
                    }
                    switch(commands[1]) {
                        case bash(value):
                            value.bin.should.be('haxelib');
                        default:
                    }
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
