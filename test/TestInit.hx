package;

import buddy.*;
using buddy.Should;

class TestInit extends BuddySuite implements Buddy {
    public function new() {
        describe('init', function () {

            describe('#submit', function () {
                it('should generate commands to submit to haxelib');
            });
            
            describe('#local', function () {
                it('should generate commands to install locally');
            });
        });
    }

}

