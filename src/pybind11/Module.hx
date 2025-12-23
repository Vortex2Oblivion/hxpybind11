package pybind11;

import cpp.Function;
import cpp.ConstCharStar;

@:include("pybind11/pybind11.h")
@:native("pybind11::module_")
extern class Module extends Object {
    var doc(get, set):ConstCharStar;


    @:native("def")
    inline function def(name:ConstCharStar, func:haxe.Constraints.Function, doc:ConstCharStar):Module{
        return untyped __cpp__("{0}.def({1}, {2}.call, {3})", this, name, Function.fromStaticFunction(func), doc);
    }

    private inline function set_doc(value:ConstCharStar):ConstCharStar {
        return untyped __cpp__("{1}.doc() = {0}", value, this);
    }

	private inline function get_doc():ConstCharStar {
		return untyped __cpp__("{0}.doc()", this);
	}
}