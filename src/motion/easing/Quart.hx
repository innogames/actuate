/**
 * @author Joshua Granick
 * @author Philippe / http://philippe.elsass.me
 * @author Robert Penner / http://www.robertpenner.com/easing_terms_of_use.html
 */


package motion.easing;


class Quart {
	
	
	static public var easeIn (get, never):IEasing;
	static public var easeInOut (get, never):IEasing;
	static public var easeOut (get, never):IEasing;
	
	
	#if commonjs
	private static function __init__ () {
		
		untyped Object.defineProperties (Quart, {
			"easeIn": { get: function () { return Quart.get_easeIn (); } },
			"easeInOut": { get: function () { return Quart.get_easeInOut (); } },
			"easeOut": { get: function () { return Quart.get_easeOut (); } }
		});
		
	}
	#end
	
	
	private static function get_easeIn ():IEasing {
		
		return new QuartEaseIn ();
		
	}
	
	
	private static function get_easeInOut ():IEasing {
		
		return new QuartEaseInOut ();
		
	}
	
	
	private static function get_easeOut ():IEasing {
		
		return new QuartEaseOut ();
		
	}
	
	
}


class QuartEaseIn implements IEasing {
	
	
	public function new () {
		
		
		
	}
	
	
	public function calculate (k:Float):Float {
		
		return k * k * k * k;
		
	}
	
	
	public function ease (t:Float, b:Float, c:Float, d:Float):Float {
		
		return c * (t /= d) * t * t * t + b;
		
	}
	
	
}


class QuartEaseInOut implements IEasing {
	
	
	public function new () {
		
		
		
	}
	
	
	public function calculate (k:Float):Float {
		
		if ((k *= 2) < 1) return 0.5 * k * k * k * k;
		return -0.5 * ((k -= 2) * k * k * k - 2);
		
	}
	
	
	public function ease (t:Float, b:Float, c:Float, d:Float):Float {
		
		if ((t /= d / 2) < 1) {
			return c / 2 * t * t * t * t + b;
		}
		return -c / 2 * ((t -= 2) * t * t * t - 2) + b;
		
	}
	
	
}


class QuartEaseOut implements IEasing {
	
	
	public function new () {
		
		
		
	}
	
	
	public function calculate (k:Float):Float {
		
		return -(--k * k * k * k - 1);
		
	}
	
	
	public function ease (t:Float, b:Float, c:Float, d:Float):Float {
		
		return -c * ((t = t / d - 1) * t * t * t - 1) + b;
		
	}
	
	
}