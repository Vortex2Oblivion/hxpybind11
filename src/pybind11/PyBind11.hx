package pybind11;

import haxe.extern.EitherType;
import cpp.Rest;
import cpp.ConstCharStar;

@:include("pybind11/embed.h")
extern class PyBind11 {
    @:native("pybind11::print")
    static function print(args:Rest<EitherType<ConstCharStar, Dynamic>>):Void;

    @:native("pybind11::exec")
    static function exec(args:Rest<EitherType<ConstCharStar, Dynamic>>):Void;
}