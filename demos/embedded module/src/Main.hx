import pybind11.*;

@:build(pybind11.macros.BindModule.bindModules())
class Main {

	static function add(i:Int, j:Int):Int {
		return i + j;
	}

	@:embeddedModule
	static function fast_calc(m:Module) {
		m.def("add", add);
	}

	static function main() {
		var guard:ScopedInterpreter = new ScopedInterpreter();

		var fast_calc = Module.importModule("fast_calc");
		var result = fast_calc.attr("add").call(1, 2).castTo(Int);
		trace(result == 3);
	}
}
