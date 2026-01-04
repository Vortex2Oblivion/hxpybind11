package;

import haxe.macro.Compiler;
import sys.io.File;
import sys.FileSystem;

class CopyFile {
	public static macro function run():Void {
		var outputDir:String = Compiler.getOutput();
		if (!FileSystem.exists(outputDir)) {
			FileSystem.createDirectory(outputDir);
		}
		File.copy("script.py", '${outputDir}/script.py');
	}
}
