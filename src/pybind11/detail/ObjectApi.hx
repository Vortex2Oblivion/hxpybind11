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

	overload extern inline function attr(key:Handle, val:Dynamic):ObjAttrAccessor {
		return untyped __cpp__("{0}.attr({1}) = {2}", this, key, val);
	}

	overload extern inline function attr(key:Reference<Reference<Object>>, val:Dynamic):ObjAttrAccessor {
		return untyped __cpp__("{0}.attr({1}) = {2}", this, key, val);
	}

	overload extern inline function attr(key:ConstCharStar, val:Dynamic):StrAttrAccessor {
		return untyped __cpp__("{0}.attr({1}) = {2}", this, key, val);
	}

	overload extern inline function call():Object {
		return untyped __cpp__("{0}()", this);
	}

	overload extern inline function call(arg:Dynamic):Object {
		return untyped __cpp__("{0}({1}", this, arg1);
	}

	overload extern inline function call(arg1:Dynamic, arg2:Dynamic):Object {
		return untyped __cpp__("{0}({1}, {2})", this, arg1, arg2);
	}

	overload extern inline function call(arg1:Dynamic, arg2:Dynamic, arg3:Dynamic):Object {
		return untyped __cpp__("{0}({1}, {2}, {3})", this, arg1, arg2, arg3);
	}

	@:native("contains")
	function contains<T>(item:Reference<Reference<T>>):Bool;
}
