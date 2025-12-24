package pybind11.detail.accessor_policies;

@:include("pybind11/pytypes.h")
@:native("pybind11::detail::accessor_policies::str_attr")
@:structAccess
extern class StrAttr {
	@:native("get")
	static function get(obj:Handle, key:Object):Object;

	@:native("set")
	static function set(obj:Handle, key:Object, value:Object):Void;
}
