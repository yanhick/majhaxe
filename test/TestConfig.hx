package;

import buddy.*;
using buddy.Should;

import Command;


class TestConfig extends BuddySuite implements Buddy {

    public function new()
    {
        describe('Config', function () {
            it('should create a config', function () {
                var config = Config.get(['minor']);
                config.semver.should.be('minor');
            });
        });
    }
}
