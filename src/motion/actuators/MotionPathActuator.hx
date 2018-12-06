package motion.actuators;


import motion.MotionPath;


class MotionPathActuator<T> extends SimpleActuator<T, T> {
	
	
	public function new (target:T, duration:Float, properties:Dynamic) {
		
		super (target, duration, properties);
		
	}
	
	
	private override function apply ():Void {
		
		for (propertyName in Reflect.fields (properties)) {
			
			#if (haxe_209 || haxe3)
			
			if (#if flash false && #end Reflect.hasField (target, propertyName)) {
				
				Reflect.setField (target, propertyName, cast (Reflect.field (properties, propertyName), IComponentPath).end);
				
			} else {
				
				Reflect.setProperty (target, propertyName, cast (Reflect.field (properties, propertyName), IComponentPath).end);
				
			}
			
			#else
			
			Reflect.setField (target, propertyName, cast (Reflect.field (properties, propertyName), IComponentPath).end);
			
			#end
			
		}
		
	}
	
	
	private override function initialize ():Void {
		
		var details:PropertyPathDetails<T>;
		var path:IComponentPath;
		
		for (propertyName in Reflect.fields (properties)) {
			
			path = cast (Reflect.field (properties, propertyName), IComponentPath);
			
			if (path != null) {
				
				var isField = true;
				
				#if (haxe_209 || haxe3)
				
				if (#if flash false && #end Reflect.hasField (target, propertyName)) {
					
					path.start = Reflect.field (target, propertyName);
					
				} else {
					
					isField = false;
					path.start = Reflect.getProperty (target, propertyName);
					
				}
				
				#else
				
				path.start = Reflect.field (target, propertyName);
				
				#end
				
				details = new PropertyPathDetails (target, propertyName, path, isField);
				propertyDetails.push (details);
				
			}
			
		}
		
		detailsLength = propertyDetails.length;
		initialized = true;
		
	}
	
	
}


#if !haxe3
import com.eclecticdesignstudio.motion.MotionPath;
#end


class PropertyPathDetails<T> extends PropertyDetails<T> {
	
	
	public var path:IComponentPath;
	
	
	public function new (target:T, propertyName:String, path:IComponentPath, isField:Bool = true) {
		
		super (target, propertyName, 0, 0, isField);
		
		this.path = path;
		
	}
	
	
	override public function getValueByEasing (easing: Float): Float {
		
		return path.calculate (easing);
		
	}
	
	
}