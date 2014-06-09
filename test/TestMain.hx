package;

import buddy.*;
using buddy.Should;


class TestMain extends BuddySuite implements Buddy {

    public function new()
    {
        describe('Git', function () {
            it('should return commands to commit to git', function () {
                var commands = Git.commit('0.1.0', null);
                commands[0].bin.should.equal('git');
                commands[0].args.length.should.equal(2);
            });

            it('should return commands to push to git', function () {
                var commands = Git.push('origin');
                commands[0].bin.should.equal('git');
                commands[0].args[0].should.equal('push');
                commands[0].args[1].should.equal('origin');
            });
        });

        describe('Config', function () {
            it('should create a config', function () {
                var config = Config.get(['minor']);
                config.semver.should.equal('minor');
            });
        });
    }
}
