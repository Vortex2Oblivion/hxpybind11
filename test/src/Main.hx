import haxe.rtti.Meta;
import pybind11.*;


@module("add", "A function that adds two numbers")
@:cppFileCode('
	PYBIND11_EMBEDDED_MODULE(example, m, pybind11::mod_gil_not_used()) {
		m.doc() = "pybind11 example plugin"; // optional module docstring

		m.def("add", &Main_obj::add, "A function that adds two numbers");
	}
')
@:keep
class Main {

	static function add(a:Int, b: Int) {
		trace(a + b);
	}

	static function main() {
		var guard:ScopedInterpreter;
		PyBind11.exec('import example
example.add(1, 2)');
	}
}
