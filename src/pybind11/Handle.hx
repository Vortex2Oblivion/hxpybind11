package pybind11;

import pybind11.detail.ObjectApi;

@:include("pybind11/pytypes.h")
@:native("pybind11::handle")
extern class Handle extends ObjectApi<Handle> {
    
}