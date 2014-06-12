package;

import buddy.*;
using buddy.Should;

class TestProject extends BuddySuite implements Buddy {
    public function new() {
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


            describe('#dependencies', function () {
                it('should generate commands to install the provided dependencies', function () {
                    var commands = Haxelib.install(['my-lib', 'your-lib']);
                    (switch(commands[0].cmd) {
                        case bash('haxelib', ['install' , 'my-lib']): true;
                        case _: false;
                    }).should.be(true);
                });
            });
            
        });
    }
}

