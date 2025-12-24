package pybind11.detail;

import cpp.ConstCharStar;
import cpp.Reference;
import cpp.Rest;
import cpp.VarArg;

@:include("pybind11/pytypes.h")
@:native("pybind11::detail::object_api")
extern class ObjectApi<T> extends PyObjectTag {
	function new():Void;

	@:native("begin")
	function begin():pybind11.Iterator;

	@:native("end")
	function end():pybind11.Iterator;

	overload extern inline function attr(key:Handle):ObjAttrAccessor {
		return untyped __cpp__("{0}.attr({1})", this, key);
	}

	overload extern inline function attr(key:Reference<Reference<Object>>):ObjAttrAccessor {
		return untyped __cpp__("{0}.attr({1})", this, key);
	}

	overload extern inline function attr(key:ConstCharStar):StrAttrAccessor {
		return untyped __cpp__("{0}.attr({1})", this, key);
	}

	inline function call(?arg1:Float, ?arg2:Float):Object {
		return untyped __cpp__("{0}()", this, arg1, arg2);
	}

	@:native("contains")
	function contains<T>(item:Reference<Reference<T>>):Bool;
}
