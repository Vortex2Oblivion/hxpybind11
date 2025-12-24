package pybind11.macros;

class NativeClassInjection {
    public macro function native():ExprOf<String> {
        return macro $v{"NativeClassInjection"};
    }
}