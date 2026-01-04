import sys.io.File;
import pybind11.PyClass;
import pybind11.*;

@:build(pybind11.macros.BindModule.bindModules())
class Main {
	@:module
	static function example(m:Module) {
		new PyClass<Pet>(m, "Pet").def(PyBind11.init(String)).def("getName");
	}

	static function main() {
		var guard:ScopedInterpreter = new ScopedInterpreter();
		PyBind11.exec(File.getContent("script.py"));
	}
}