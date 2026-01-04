package pybind11;

import pybind11.detail.initimpl.Constructor;
import cpp.Reference;
import haxe.extern.EitherType;
import cpp.Rest;
import cpp.ConstCharStar;


@:include("pybind11/embed.h")
@:include("pybind11/pytypes.h")
extern class PyBind11 {
	@:native("pybind11::print")
	static function print(args:Rest<EitherType<ConstCharStar, Dynamic>>):Void;

	@:native("pybind11::exec")
	static function exec(args:Rest<EitherType<ConstCharStar, Dynamic>>):Void;

	inline static function init<T>(args:Dynamic):Constructor {
		return untyped  __cpp__("pybind11::init<>()", args);
	}

	overload extern inline static function set_error(type:Reference<Handle>, message:ConstCharStar):Void {
		untyped __cpp__("pybind11::set_error({0}, {1})", type, message);
	}

	overload extern inline static function set_error(type:Reference<Handle>, value:Reference<Handle>):Void {
		untyped __cpp__("pybind11::set_error({0}, {1})", type, value);
	}
	
}
