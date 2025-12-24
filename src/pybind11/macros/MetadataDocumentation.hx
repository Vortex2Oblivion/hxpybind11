package pybind11.macros;

#if macro
import haxe.macro.Compiler;
import haxe.macro.Context;
#end

class MetadataDocumentation {
	public static function run() {
        #if macro
		Compiler.registerCustomMetadata({
			targets: [ClassField],
			platforms: [Cpp],
			params: [],
			links: ["https://pybind11.readthedocs.io/en/stable/advanced/embedding.html"],
			metadata: ":embeddedModule",
			doc: "Binds a function to an embedded Python module."
		}, "hxpybind11");
		return Context.getBuildFields();
        #end
	}
}
