package;

import buddy.*;
using buddy.Should;

import Command;
import Config;


class TestConfig extends BuddySuite implements Buddy {

    public function new()
    {
        describe('Config', function () {
            it('should create a config', function () {
                var config = ConfigImpl.get(['minor']);
                config.semver.should.be('minor');
            });
        });
    }
}
