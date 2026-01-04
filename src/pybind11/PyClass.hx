package pybind11;

import haxe.Constraints.Function;
import pybind11.detail.initimpl.Constructor;
import pybind11.detail.GenericType;
import cpp.ConstCharStar;

@:include("pybind11/pybind11.h")
@:native("pybind11::class_")
extern class PyClass<T> extends GenericType {
	@:native("pybind11::class_::has_alias")
	static var hasAlias:Bool;

	function new(scope:Handle, name:ConstCharStar):Void;

	overload extern inline function def(name:ConstCharStar):PyClass<T> {
		return untyped __cpp__("{0}.def({1}, ::cpp::Function<void(::String)>(&::Pet_obj::getName).call)", this, name);
	}

	overload extern inline function def<T>(init:Constructor):PyClass<T> {
		return untyped __cpp__("{0}.def({1})", this, init);
	}
}
