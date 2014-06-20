package;

import buddy.*;
using buddy.Should;

import Command;
import commands.Init;
import UserInput;
import Config;

using Lambda;

class TestInit extends BuddySuite implements Buddy {

    public function new()
    {
        var createInput = function () {
            return {
                project: 'test-project',
                url: 'project-url',
                version: '0.0.0',
                description: 'my test project',
                license: MIT,
                source: 'source',
                holder: 'test holder',
                dependencies: ['mylib'],
                targets: ['js']
            };
        };

        var createIO = function () {
            return  {
                input: function () return '',
                output: function (str) {},
                read: function (content) return '',
                write: function (path, content){},
                exists: function (path) return true
            };
        }

        var createResource = function () {
           return  {
                createMIT: function(date, holder) {
                    return 'MIT';
                },
                createTravis: function (deps, build) {
                    return 'travis';
                },
                createMain: function (pack) {
                    return 'main';
                },
                createReadme: function (name, description) {
                    return 'readme';
                },
                createHXML: function (targets, libs, path) {
                    return 'hxml';
                },
                createHaxelib: function (input) {
                    return 'haxelib';
                }
           }
        };

        var createConfig = function () {
            return {
                semver: '0.1.0',
                noCommit: false,
                noPush: false,
                noGit: false,
                comment: 'comment',
                remote: null,
                exclude: null,
                dryRun: false
            }
        }

        describe('Init', function () {
            it('should create a full projectrepo', function () {
                var input:InitInput = createInput();
                var io:IO = createIO();
                var resource:Resources = createResource();

                io.write = function (path, resource) {
                    ['license.md', '.travis.yml', 
                    input.source + '/Main.hx', 
                    'readme.md', 'build.hxml'].has(path).should.be(true);
                };
                

                resource.createMIT = function(date, holder) {
                    date.should.be(Date.now().getFullYear());
                    holder.should.be('test holder');
                    return 'MIT';
                };
                resource.createTravis = function (deps, build) {
                    deps[0].should.be('mylib');
                    build.should.be('haxe build.hxml');
                    return 'travis';
                };
                resource.createMain = function (pack) {
                    pack.should.be('test-project');
                    return 'main';
                };
                resource.createReadme = function (name, description) {
                    name.should.be('test-project');
                    description.should.be('my test project');
                    return 'readme';
                };
                resource.createHXML = function (targets, libs, path) {
                    targets[0].should.be('js');
                    libs[0].should.be('mylib');
                    path.should.be('test-project');
                    return 'hxml';
                };
                resource.createHaxelib = function (input) {
                    return 'haxelib';
                };

                var getInput = function () return input;

                var commands = Init.get(createConfig(), io, resource, getInput);
                commands.foreach(function (command) {
                    return switch(command.cmd) {
                        case func(fn):
                            fn();
                            true;
                        case bash('git', ['init']): true;
                        case bash('mkdir', _): true;
                        case _: false;
                    }
                }).should.be(true);
            });

            it('should not create a git repo', function () {
                var getInput = function () return createInput();
                var config:Config = createConfig();
                config.noGit = true;
                var commands = Init.get(config, createIO(), createResource(), getInput);
                commands.foreach(function (command) {
                    return switch(command.cmd) {
                        case bash('git', ['init']): false;
                        case _: true;
                    }
                }).should.be(true);
            });
        });
    }
}
