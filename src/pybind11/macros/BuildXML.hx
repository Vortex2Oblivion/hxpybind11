package pybind11.macros;

import haxe.macro.Compiler;
import haxe.macro.Context;
import haxe.macro.Expr;
import sys.FileSystem;
import sys.io.Process;

using StringTools;

class BuildXML {
	public static macro function run():Void {
		var buildXML:String = "@:buildXml(\"
            <include name='${haxelib:hxpybind11}/build.xml' />
            
	
            <target id='haxe'>
                <lib name='__PYTHON__LIB__FILE__' />
            </target>
        \")";

		/*var process:Process = new Process('where', ['python']);
			if (process.exitCode() != 0) {
				var message:String = process.stderr.readAll().toString();
				var pos:Position = Context.currentPos();
				Context.error("Cannot find python on your system! " + message, pos);
			}


			var possiblePaths:Array<String> = process.stdout.readLine().split("\n");

			var foundPath:String;

			for(path in possiblePaths){
				if(path.contains("Python315")){
					foundPath = path;
					break;
				}
			}

			buildXML = buildXML.replace('__PYTHON__PATH__', foundPath.replace("python.exe", 'libs/python315.lib'));
			buildXML = buildXML.replace("\\", "/"); */

		var findLib:Process = new Process('haxelib', ['libpath', 'hxpybind11']);
		if (findLib.exitCode() != 0) {
			var message:String = findLib.stderr.readAll().toString();
			var pos:Position = Context.currentPos();
			findLib.close();
			Context.error(message, pos);
		}

		var libPath:String = findLib.stdout.readLine();
		findLib.close();

		if (Context.defined('COMPILE_CPYTHON') || !FileSystem.exists('${libPath}external/cpython/libpython3.15d.a')) {
			Sys.println("Compiling CPython...");
			var oldDir:String = Sys.getCwd();

			try {
				for (command in ['cd ${libPath}external/cpython', './configure --with-pydebug', 'make']) {
                    Sys.command(command);
					while (command == 'make' && !FileSystem.exists('${libPath}external/cpython/Makefile')) {
						Sys.sleep(0.1);
					}
				}
			} catch (e:Dynamic) {
				Context.error(e, Context.currentPos());
			}
			Sys.command('cd $oldDir');
		}

		buildXML = buildXML.replace('__PYTHON__LIB__FILE__', "${cpython_folder}/libpython3.15d.a");
		buildXML = buildXML.replace("\\", "/");

		Compiler.addGlobalMetadata('pybind11', buildXML);
	}
}
