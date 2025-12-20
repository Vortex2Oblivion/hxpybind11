package pybind11.macros;

import haxe.macro.Compiler;
import haxe.macro.Context;
import haxe.macro.Expr;
import sys.io.Process;

using StringTools;

class BuildXML {
	public static macro function run() {
        var buildXML:String = 
        "@:buildXml(\"
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
        buildXML = buildXML.replace("\\", "/");*/

        var process:Process = new Process('haxelib', ['libpath', 'hxpybind11']);
        if (process.exitCode() != 0) {
			var message:String = process.stderr.readAll().toString();
			var pos:Position = Context.currentPos();
            process.close();
			Context.error(message, pos);
		}


        var libpath:String = process.stdout.readLine();
        process.close();

        var oldDir:String = Sys.getCwd();

        var process:Process = new Process('haxelib', ['libpath', 'hxpybind11']);
        if (process.exitCode() != 0) {
			var message:String = process.stderr.readAll().toString();
			var pos:Position = Context.currentPos();
            process.close();
			Context.error(message, pos);
		}

        try{
        Sys.command('cd $libpath/external/cpython');
        Sys.command('./configure --with-pydebug');
        Sys.command('make');
        }
        catch(e:Dynamic){
        }
        Sys.command('cd $oldDir');

        
        buildXML = buildXML.replace('__PYTHON__LIB__FILE__', "${cpython_folder}/libpython3.15d.a");
        buildXML = buildXML.replace("\\", "/");

		Compiler.addGlobalMetadata('pybind11', buildXML);
        return macro null;
	}
}