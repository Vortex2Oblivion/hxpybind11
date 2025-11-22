package pybind11;

@:include("pybind11/embed.h")
@:native("pybind11::scoped_interpreter")
@:buildXml("<include name='${haxelib:hxpybind11}/build.xml' />")
extern class ScopedInterpreter {
    
}
