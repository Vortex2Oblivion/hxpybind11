package pybind11.macros;

import eval.luv.Stream;
import haxe.macro.Compiler;
import haxe.macro.Context;
import haxe.macro.Expr;
import haxe.macro.Type;
import haxe.macro.ExprTools;

class BindModule {
	private static function packageToNamepsace(pack:Array<String>) {
		if (pack.length == 0)
			return "";
		var namespaceString:String = "";
		for (p in pack) {
			namespaceString += p + "::";
		}
		return namespaceString;
	}

    // riconuts my goat thank you so much for this
	public static macro function bindModules():Array<Field> {
		var localClass = Context.getLocalClass();
		var cl:ClassType = localClass.get();
		var clMeta = cl.meta;

        var outputCode:String = '';

		for (meta in clMeta.extract(':module')) {
			var module:String = ExprTools.getValue(meta.params[0]);

			var funcs:Array<Array<String>> = ExprTools.getValue(meta.params[1]);

			var cppFuncDefs = "";

			for (funcData in funcs) {
				var funcName = funcData[0];
				var funcDesc = funcData[1];

				cppFuncDefs += 'm.def("$funcName", &${packageToNamepsace(cl.pack)}${cl.name}_obj::$funcName, "$funcDesc");\n';
			}
			var doc:String = try {
				ExprTools.getValue(meta.params[2]);
			} catch (e) {
				var f = () -> {
					Context.warning('No docstring provided for module "$module"', Context.currentPos());
					return "";
				}
				f();
			};

			outputCode += '
            PYBIND11_EMBEDDED_MODULE($module, m, pybind11::mod_gil_not_used()) {
                m.doc() = "$doc";

                $cppFuncDefs
            }
            \n
			';
            clMeta.add(":cppFileCode", [{pos: meta.pos, expr: EConst(CString(outputCode))}], meta.pos);
		}

		return Context.getBuildFields();
	}
}
