import haxe.Json;
import sys.io.File;
import pybind11.*;

@:build(pybind11.macros.BindModule.bindModules())
@:embeddedModule("example", [
	["add", "A function that adds two numbers"],
	["subtract", "A function that subtracts two numbers"]
], "pybind11 example plugin")
@:embeddedModule("haxemath", [
	["Math.random", "A function that returns a random number"]
], "haxe math functions")
class Main {
	static function add(a:Int, b:Int) {
		return (a + b);
	}

	static function subtract(a:Int, b:Int) {
		return (a - b);
	}

	static function random() {
		return (Math.random());
	}

	static function main() {
		var guard:ScopedInterpreter = new ScopedInterpreter();
		PyBind11.exec(File.getContent("script.py"));
	}
}
