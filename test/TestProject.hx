package;

import buddy.*;
using buddy.Should;

class TestProject extends BuddySuite implements Buddy {
    public function new() {
        var getBin = function (command:Command) {
            return switch(command.cmd) {
                case bash(bin, args): bin;
                default: throw 'not a bash command';
            }
        };

        var getArgs = function (command:Command) {
            return switch(command.cmd) {
                case bash(bin, args): args;
                default: throw 'not a bash command';
            }
        };

        describe('project', function () {

            describe('#haxelib', function () {
                it('should generate a haxelib.json file');
            });
            
            describe('#git', function () {
                it('should init a git repo', function () {
                    (switch(Git.init().cmd) {
                        case bash('git', ['init']): true;
                        case _: false;
                    }).should.be(true);
                });
            });

            describe('#licence', function () {
                it('should generate a licence for the project', function () {
                    var licence = Licence.createMIT(
                        Date.now().getFullYear(),
                        'test holder');
                    licence.indexOf(Std.string(Date.now().getFullYear())).should.not.be(-1);
                    licence.indexOf('test holder').should.not.be(-1);
                });
            });

            describe('#dependencies', function () {
                it('should generate commands to install the provided dependencies', function () {
                    var commands = Haxelib.install(['my-lib', 'your-lib']);
                    (switch(commands[0].cmd) {
                        case bash('haxelib', ['install' , 'my-lib']): true;
                        case _: false;
                    }).should.be(true);
                });
            });

            describe('#readme', function () {
                it('should create a readme');
            });
            
            describe('#travis', function () {
                it('should add a travis file');
            });

            describe('#source', function () {
                it('should create a source folder');
                it('should create a Main file');
            });

            describe('#hxml', function () {
                it('should create an hxml file');
            });
        });
    }
}

