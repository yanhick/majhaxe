default:
	haxe build.hxml

run-test:
	haxe build-tests.hxml
	neko test.n
