package pybind11;

import cpp.Float32;
import cpp.Float64;
import cpp.Int64;
import cpp.UInt64;

@:include("pybind11/pytypes.h")
@:native("pybind11::object")
@:include("HaxeToCpp.hpp")
extern class Object extends Handle {
	@:native("release")
	function release():Handle;

	inline function castTo<T>(type:Dynamic):Dynamic {
		var r:Dynamic = null;
		switch (type) {
			case Int:
				r = untyped __cpp__("{0}.cast<int>()", this);
			case Int64:
				r = untyped __cpp__("{0}.cast<::cpp::Int64>()", this);
			case UInt64:
				r = untyped __cpp__("{0}.cast<uint64_t>()", this);
			case Float:
				r = untyped __cpp__("{0}.cast<::Float>()", this);
			case Float32:
				r = untyped __cpp__("{0}.cast<::cpp::Float32>()", this);
			case Float64:
				r = untyped __cpp__("{0}.cast<::cpp::Float64>()", this);
			case Bool:
				r = untyped __cpp__("{0}.cast<bool>()", this);
			case String:
				r = untyped __cpp__("{0}.cast<::String>()", this);
			case null:
				r = untyped __cpp__("{0}.cast<null>()", this);
			default:
				r = untyped __cpp__("{0}.cast<::Dynamic>()", this);
		}
		return cast r;
	}
}
