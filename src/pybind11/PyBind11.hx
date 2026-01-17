package pybind11;

import cpp.RawStdString;
import cpp.StdString;
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

	inline overload extern static function init<T>(arg1:Class<String>):Constructor<String> {
		return untyped __cpp__("pybind11::init<String>()");
		/*var int:Constructor<Int>;
			var int64:Constructor<Int64>;
			var uint64:Constructor<UInt64>;
			var float:Constructor<Float>;
			var float32:Constructor<Float32>;
			var float64:Constructor<Float64>;
			var bool:Constructor<Bool>;
			var string:Constructor<String>;
			var dyn:Constructor<Dynamic>;

			switch (arg1) {
				case Int:
					int = untyped __cpp__("pybind11::init<int>()");
					return cast int;
				case Int64:
					int64 = untyped __cpp__("pybind11::init<::cpp::Int64>()");
					return cast int64;
				case UInt64:
					uint64 = untyped __cpp__("pybind11::init<uint64_t>()");
					return cast uint64;
				case Float:
					float = untyped __cpp__("pybind11::init<::Float>()");
					return cast float;
				case Float32:
					float32 = untyped __cpp__("pybind11::init<::cpp::Float32>()");
					return cast float32;
				case Float64:
					float64 = untyped __cpp__("pybind11::init<::cpp::Float64>()");
					return cast float64;
				case Bool:
					bool = untyped __cpp__("pybind11::init<bool>()");
					return cast bool;
				case String:
					string = untyped __cpp__("pybind11::init<::String>()");
					return cast string;
				default:
					dyn = untyped __cpp__("pybind11::init<::Dynamic>()");
					return cast dyn;
		}*/
	}

	inline overload extern static function init<T>(arg1:Class<StdString>):Constructor<ConstCharStar> {
		return untyped __cpp__("pybind11::init<const char *>()");
	}

	inline overload extern static function init<T>(arg1:Int):Constructor<Int> {
		return untyped __cpp__("pybind11::init<int>()");
	}

	overload extern inline static function set_error(type:Reference<Handle>, message:ConstCharStar):Void {
		untyped __cpp__("pybind11::set_error({0}, {1})", type, message);
	}

	overload extern inline static function set_error(type:Reference<Handle>, value:Reference<Handle>):Void {
		untyped __cpp__("pybind11::set_error({0}, {1})", type, value);
	}
}
