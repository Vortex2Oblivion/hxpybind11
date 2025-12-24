package pybind11;

import haxe.extern.EitherType;
import cpp.Reference;
import cpp.RawPointer;
import cpython.PyObject;
import pybind11.detail.ObjectApi;

@:include("pybind11/pytypes.h")
@:native("pybind11::handle")
extern class Handle extends ObjectApi<Handle> {
    @:native("ptr")
    function ptr():EitherType<Reference<RawPointer<PyObject>>, RawPointer<PyObject>>;

    @:native("inc_ref")
    function inc_ref():Reference<Handle>;

    @:native("dec_ref")
    function dec_ref():Reference<Handle>;
}
