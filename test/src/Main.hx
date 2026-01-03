
import pybind11.*;

@:build(pybind11.macros.BindModule.bindModules())
class Main {
	@:embeddedModule
	static function haxemath(m:Module) {
		m.doc = "haxe math functions";
		m.def("random", Math.random, "A function that returns a random number");
		m.def("round", Math.round, "A function that rounds a number");
		m.def("min", Math.min, "A function that returns the minimum of two numbers");
	}

	static function main() {
		var guard:ScopedInterpreter = new ScopedInterpreter();

		var haxemath:Module = Module.importModule("haxemath");
		var result:Float = haxemath.attr("random").call().castTo(Float);
		trace(result);
	}
}
