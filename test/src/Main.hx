import cpp.RawPointer;
import cpp.Function;
import cpp.Callable;
import haxe.Json;
import sys.io.File;
import pybind11.*;

@:build(pybind11.macros.BindModule.bindModules())
@:cppFileCode('
PYBIND11_EMBEDDED_MODULE(haxemath, m, pybind11::mod_gil_not_used()) {
    Main_obj::testModule(m);
}
')
/*@:embeddedModule("example", [
	["add", "A function that adds two numbers"],
	["subtract", "A function that subtracts two numbers"]
], "pybind11 example plugin")
@:embeddedModule("haxemath", [
	["Math.random", "A function that returns a random number"]
], "haxe math functions")*/
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

	@:unreflective
	static function testModule(m:Module){
		m.doc = "haxe math functions";
		m.def("random", Math.random, "A function that returns a random number");
		m.def("round", Math.round, "A function that rounds a number");
	}

	static function main() {
		var guard:ScopedInterpreter = new ScopedInterpreter();
		PyBind11.exec(File.getContent("script.py"));
	}
}
