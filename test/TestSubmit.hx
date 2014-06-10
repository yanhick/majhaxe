package;

import buddy.*;
using buddy.Should;

class TestSubmit extends BuddySuite implements Buddy {
    public function new() {
        describe('submit', function () {

            describe('#submit', function () {
                it('should generate commands to submit to haxelib');
            });
            
            describe('#local', function () {
                it('should generate commands to install locally');
            });
        });
    }

}

