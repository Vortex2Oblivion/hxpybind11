package pybind11;

@:include("pybind11/embed.h")
@:native("pybind11::scoped_interpreter")
extern class ScopedInterpreter {
    function new():Void;
}
