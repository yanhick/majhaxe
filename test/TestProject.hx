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
                it('should init a git repo');
            });

            describe('#licence', function () {
                it('should generate a licence for the project');
            });

            describe('#dependencies', function () {
                it('should install the provided dependencies');
            });
        });
    }
}

