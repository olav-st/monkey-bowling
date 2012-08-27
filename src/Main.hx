import com.haxepunk.Engine;
import com.haxepunk.HXP;
import com.haxepunk.utils.Key;
import worlds.Menu;
import worlds.Play;

class Main extends Engine
{

	public static inline var kScreenWidth:Int = 720;
	public static inline var kScreenHeight:Int = 480;
	public static inline var kFrameRate:Int = 30;
	public static inline var kClearColor:Int = 0x333333;
	public static inline var kProjectName:String = "HaxePunk";

	public function new()
	{
		super(kScreenWidth, kScreenHeight, kFrameRate, false);
	}

	override public function init()
	{
		//HXP.console.toggleKey = Key.TAB;
#if debug
	#if flash
		if (flash.system.Capabilities.isDebugger)
	#end
		{
			HXP.console.enable();
		}
#end
		//HXP.console.enable();
		HXP.screen.color = kClearColor;
		HXP.screen.scale = 1;
		HXP.world = new Menu();
	}

	public static function main()
	{
		new Main();
	}

}