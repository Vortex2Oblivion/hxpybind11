import cpp.NativeString;
import pybind11.*;

class Main {
	static function main() {
		var guard:ScopedInterpreter = new ScopedInterpreter();

		var calc:Module = Module.importModule("calc");

		var result:Object = calc.attr("add").call(1, 2);

		var n:Int = result.castTo(Int);
		
		trace(n == 3);
	}
}
