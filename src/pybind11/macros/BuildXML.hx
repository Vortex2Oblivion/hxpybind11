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
            
	
            <target id='haxe' tool='linker' toolid='exe' >
                <lib name='__PYTHON__PATH__' />
            </target>
        \")";

        var process:Process = new Process('where', ['python']);
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
        buildXML = buildXML.replace("\\", "/");

		Compiler.addGlobalMetadata('pybind11', buildXML);
        return macro null;
	}
}