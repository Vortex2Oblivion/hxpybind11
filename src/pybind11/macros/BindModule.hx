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

	public static macro function bindModules():Array<Field> {
		#if macro
		var localClass = Context.getLocalClass();
		var cl:ClassType = localClass.get();
		var clMeta:MetaAccess = cl.meta;

		var outputCode:String = clMeta.extract(':cppFileCode').length > 0 ? ExprTools.getValue(clMeta.extract(':cppFileCode')[0].params[0]) : "";

		var fields:Array<Field> = Context.getBuildFields();
		for (field in fields) {
			for (meta in field.meta) {
				if (meta.name == ":embeddedModule") {
					field.meta.push({name: ":unreflective", params: [], pos: meta.pos});
					field.meta.push({name: ":keep", params: [], pos: meta.pos});
					outputCode += '\nPYBIND11_EMBEDDED_MODULE(${field.name}, m, pybind11::mod_gil_not_used()) { ${packageToNamepsace(cl.pack)}${cl.name}_obj::${field.name}(m); }';
					clMeta.add(":cppFileCode", [{pos: meta.pos, expr: EConst(CString(outputCode))}], meta.pos);
				}
			}
		}
		return fields;
		#end
	}
}
