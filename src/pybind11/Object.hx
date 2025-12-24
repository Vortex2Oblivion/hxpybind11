package pybind11;

import cpp.Struct;

@:include("pybind11/pytypes.h")
@:include("HaxeToCpp.hpp")
@:native("pybind11::object")
extern class Object extends Handle {
    @:native("release")
    function release():Handle;

    inline extern function castTo<T>(type:T):Dynamic {
        return untyped __cpp__("{0}.cast<EXTRACT_TYPE({1})>()", this, type);
    }
}
