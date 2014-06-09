default:
	haxe build.hxml

run-test:
	haxe -lib buddy -main Main -cp test --interp
