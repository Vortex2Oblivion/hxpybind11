package pybind11.macros;

import haxe.macro.Compiler;
import haxe.macro.Context;
import haxe.macro.Expr;
import sys.FileSystem;
import sys.io.Process;
import sys.io.File;

using StringTools;

class BuildXML {
	public static macro function run():Void {
		var buildXML:String = "@:buildXml(\"
            <include name='${haxelib:hxpybind11}/build.xml' />
            
	
            <target id='haxe'>
                <lib name='__PYTHON__LIB__FILE__' />
            </target>
        \")";

		var findLib:Process = new Process('haxelib', ['libpath', 'hxpybind11']);
		if (findLib.exitCode() != 0) {
			var message:String = findLib.stderr.readAll().toString();
			var pos:Position = Context.currentPos();
			findLib.close();
			Context.error(message, pos);
		}

		var libPath:String = findLib.stdout.readLine();
		findLib.close();

		var outputFile:String = Sys.systemName() == "Windows" ? "PCbuild/amd64/python315_d.lib" : "libpython3.15d.a";

		if (Context.defined('COMPILE_CPYTHON') || !FileSystem.exists('${libPath}external/cpython/$outputFile')) {
			Sys.println("Compiling CPython...");
			var oldDir:String = Sys.getCwd();

			var commands:Array<String> = Sys.systemName() == "Windows" ? [
				'cd ${libPath}external/cpython/PCbuild',
				'build.bat -c Debug',
				'amd64/python_d.exe'
			] : ['cd ${libPath}external/cpython', './configure --with-pydebug', 'make'];

			try {
				for (command in commands) {
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

		if (Sys.systemName() == "Windows") {
			// ????
			File.copy('${libPath}external/cpython/$outputFile', '${libPath}external/cpython/${outputFile = outputFile.replace('_d', '')}');
		}

		buildXML = buildXML.replace('__PYTHON__LIB__FILE__', "${cpython_folder}/" + outputFile);
		buildXML = buildXML.replace("\\", "/");

		Compiler.addGlobalMetadata('pybind11', buildXML);
	}
}
