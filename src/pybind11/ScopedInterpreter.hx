package pybind11;

import cpp.ConstCharStar;
import cpp.RawConstPointer;

@:include("pybind11/embed.h")
@:native("pybind11::scoped_interpreter")
extern class ScopedInterpreter {
	@:overload(function(initSignalHandlers:Bool = true, argc:Int = 0, argv:RawConstPointer<ConstCharStar> = cast 0, addProgramDirToPath:Bool = true):Void {})
	function new():Void;
}
