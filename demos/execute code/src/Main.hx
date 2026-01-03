import pybind11.*;

class Main {
	static function main() {
		var guard:ScopedInterpreter = new ScopedInterpreter();

		PyBind11.exec('kwargs = dict(name="World", number=42)
message = "Hello, {name}! The answer is {number}".format(**kwargs)
print(message)'
		);
	}
}
