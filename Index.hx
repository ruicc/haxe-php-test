import php.Lib;
import sys.FileSystem;

import core.Route;

class Index
{
	static function main()
	{
		var routing = Route.make();
		var ctl = routing("Piyo"); // "Piyo"文字列からPiyoオブジェクトを生成
		trace("class:" + ctl.action());
	}
}
