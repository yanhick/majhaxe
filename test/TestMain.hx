package;

import buddy.*;
using buddy.Should;


class TestMain extends BuddySuite implements Buddy {

    public function new()
    {
        describe('Git', function () {
            it('should return commands to commit to git', function () {
                var commands = Git.commit('0.1.0', null);
                commands[0].bin.should.be('git');
                commands[0].args.length.should.be(2);
            });

            it('should return commands to push to git', function () {
                var commands = Git.push('origin');
                commands[0].bin.should.be('git');
                commands[0].args[0].should.be('push');
                commands[0].args[1].should.be('origin');
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
                    commands[0].bin.should.be('zip');
                    commands[1].bin.should.be('haxelib');
                    commands[1].args[0].should.be('local');
                    commands[2].bin.should.be('rm');
                });
            });

            describe('#submit', function () {
                it('should submit to haxelib', function () {
                    var commands = Haxelib.submit(Config.get(['minor']));
                    commands[0].bin.should.be('zip');
                    commands[1].bin.should.be('haxelib');
                    commands[1].args[0].should.be('submit');
                    commands[2].bin.should.be('rm');
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
