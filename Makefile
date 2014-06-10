default:
	haxe build.hxml

run:
	haxe build.hxml
	neko run.n

run-test:
	haxe build-tests.hxml
	neko test.n
