package pybind11.macros;

#if macro
import haxe.macro.Context;
import haxe.macro.Expr;
import haxe.macro.Type;
import haxe.macro.ExprTools;

using StringTools;
#end

class BindModule {
	private static function packageToNamepsace(pack:Array<String>) {
		#if macro
		if (pack.length == 0)
			return "";
		var namespaceString:String = "";
		for (p in pack) {
			namespaceString += p + "::";
		}
		return namespaceString;
		#end
	}

	// riconuts my goat thank you so much for this
	public static macro function bindModules():Array<Field> {
		#if macro
		var localClass = Context.getLocalClass();
		var cl:ClassType = localClass.get();
		var clMeta:MetaAccess = cl.meta;

		var outputCode:String = clMeta.extract(':cppFileCode').length > 0 ? ExprTools.getValue(clMeta.extract(':cppFileCode')[0].params[0]) : "";

		function bindModule(meta:MetadataEntry, embedded:Bool = false):Void {
			var module:String = ExprTools.getValue(meta.params[0]);

			var funcs:Array<Array<String>> = ExprTools.getValue(meta.params[1]);

			var cppFuncDefs:String = "";

			for (funcData in funcs) {
				var split:Array<String> = funcData[0].split('.');

				var funcName:String = split[split.length - 1];

				var className:String = cl.name;

				if (funcName.split('.').length >= 1 && split[0] != funcName) {
					className = split[0];
				}

				var funcDesc:String = funcData[1];

				cppFuncDefs += 'm.def("$funcName", &${packageToNamepsace(cl.pack)}${className}_obj::$funcName, "$funcDesc");\n';
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
            PYBIND11_${embedded ? "EMBEDDED_" : ""}MODULE($module, m, pybind11::mod_gil_not_used()) {
                m.doc() = "$doc";

                $cppFuncDefs
            }
            \n
			';
			clMeta.add(":cppFileCode", [{pos: meta.pos, expr: EConst(CString(outputCode))}], meta.pos);
		}

		for (meta in clMeta.extract(':module')) {
			bindModule(meta, false);
		}

		for (meta in clMeta.extract(':embeddedModule')) {
			bindModule(meta, true);
		}

		return Context.getBuildFields();
		#end
	}
}
