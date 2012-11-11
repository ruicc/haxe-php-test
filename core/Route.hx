package core;
import haxe.macro.Context;
import haxe.macro.Expr;
import sys.FileSystem;
import Lambda;
using Lambda;

// コントローラ全追加必要...?
import controller.Hoge;
import controller.Fuga;
import controller.Piyo;

class Route
{
	@:macro public static function makeRoutingFunction() : Expr
	{
		// Controller directoryを走査してクラス全部取得
		var controllerDir = "./controller";
		var files = sys.FileSystem.readDirectory(controllerDir);
		var classNames = files.map(function(file) { 
			var r = ~/([a-zA-Z0-9_]+)\.hx/;
			r.match(file);
			return r.matched(1);
		}).array();
		trace("controller names:" + classNames);

		var routeFunc = "function (str) { return switch (str) {";
		for (className in classNames) {
			routeFunc += "case \"" + className + "\": new " + className + "();";
		}
		// Context.parseは文字列をhaxe構文と解釈してparse、Exprを返す
		return Context.parse(routeFunc + "}}", Context.currentPos());
	}

	static public function make()
	{
		return makeRoutingFunction();
	}
}
