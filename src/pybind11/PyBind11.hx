package pybind11;

@:include("pybind11/embed.h")
@:buildXml("<include name='${haxelib:hxpybind11}/build.xml' />")
extern class PyBind11 {
    @:native("pybind11::print")
    static function print():Void;
}