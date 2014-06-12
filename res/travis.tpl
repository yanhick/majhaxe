language: php

before_script:
  - sudo apt-get update
  - sudo apt-get install python-software-properties -y
  - sudo add-apt-repository ppa:eyecreate/haxe -y
  - sudo apt-get update
  - sudo apt-get install haxe -y
  - mkdir ~/haxelib
  - haxelib setup ~/haxelib
  ::foreach libs::- haxelib install ::__current__::::end::

script:
  - haxe ::build::
  - neko test.n

