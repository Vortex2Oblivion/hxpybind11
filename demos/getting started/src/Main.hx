
import pybind11.*; // import all types

class Main {
	static function main() {
		var guard:ScopedInterpreter = new ScopedInterpreter(); // start the interpreter and keep it alive
		
		PyBind11.print("Hello, World!");  // use the Python API
	}
}
