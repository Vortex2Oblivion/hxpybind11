import sys.io.File;
import pybind11.*;

@:build(pybind11.macros.BindModule.bindModules())
class Main {
	@:embeddedModule
	static function example(m:Module) {
		var p = new PyClass<Pet>(m, "Pet");
		untyped __cpp__('{0}.def("new", &Pet_obj::__new)', p);
	}

	static function main() {
		var guard:ScopedInterpreter = new ScopedInterpreter();
		PyBind11.exec(File.getContent("script.py"));
	}
}
