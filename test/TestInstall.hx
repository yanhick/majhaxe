package;

import buddy.*;
using buddy.Should;

class TestInstall extends BuddySuite implements Buddy {
    public function new() {
        describe('install', function () {

            describe('#dependencies', function () {
                it('should store the installed dependencies in the haxelib.json file');
            });
        });
    }

}

