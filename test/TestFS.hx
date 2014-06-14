package;

import buddy.*;
using buddy.Should;

class TestFS extends BuddySuite implements Buddy {
    public function new() {
        describe('FS', function () {
            describe('#mkdir', function () {
                it('should create a create folder command', function () {
                    var command = FS.mkdir('test');
                    (switch(command.cmd) {
                        case bash('mkdir', ['test']): true;
                        case _: false;
                    }).should.be(true);
                });
            });

            describe('#cd', function () {
                it('should create a command to change current directory', function () {
                    var command = FS.cd('test');

                    (switch(command.cmd) {
                        case bash('cd', ['test']): true;
                        case _: false;
                    }).should.be(true);
                });
            });

            describe('#write', function () {
                it('should create a write to file command', function () {
                    var command = FS.write('testFile.json', 'my contnent');

                    (switch(command.cmd) {
                        case func(fn): true;
                        case _: false;
                    }).should.be(true);

                });
            });

            describe('#read', function () {
                it('should create a read from file command');
            });
        });
    }

}

