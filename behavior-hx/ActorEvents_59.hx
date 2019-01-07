package scripts;

import com.stencyl.graphics.G;
import com.stencyl.graphics.BitmapWrapper;

import com.stencyl.behavior.Script;
import com.stencyl.behavior.Script.*;
import com.stencyl.behavior.ActorScript;
import com.stencyl.behavior.SceneScript;
import com.stencyl.behavior.TimedTask;

import com.stencyl.models.Actor;
import com.stencyl.models.GameModel;
import com.stencyl.models.actor.Animation;
import com.stencyl.models.actor.ActorType;
import com.stencyl.models.actor.Collision;
import com.stencyl.models.actor.Group;
import com.stencyl.models.Scene;
import com.stencyl.models.Sound;
import com.stencyl.models.Region;
import com.stencyl.models.Font;
import com.stencyl.models.Joystick;

import com.stencyl.Engine;
import com.stencyl.Input;
import com.stencyl.Key;
import com.stencyl.utils.Utils;

import openfl.ui.Mouse;
import openfl.display.Graphics;
import openfl.display.BlendMode;
import openfl.display.BitmapData;
import openfl.display.Bitmap;
import openfl.events.Event;
import openfl.events.KeyboardEvent;
import openfl.events.TouchEvent;
import openfl.net.URLLoader;

import box2D.common.math.B2Vec2;
import box2D.dynamics.B2Body;
import box2D.dynamics.B2Fixture;
import box2D.dynamics.joints.B2Joint;

import motion.Actuate;
import motion.easing.Back;
import motion.easing.Cubic;
import motion.easing.Elastic;
import motion.easing.Expo;
import motion.easing.Linear;
import motion.easing.Quad;
import motion.easing.Quart;
import motion.easing.Quint;
import motion.easing.Sine;

import com.stencyl.graphics.shaders.BasicShader;
import com.stencyl.graphics.shaders.GrayscaleShader;
import com.stencyl.graphics.shaders.SepiaShader;
import com.stencyl.graphics.shaders.InvertShader;
import com.stencyl.graphics.shaders.GrainShader;
import com.stencyl.graphics.shaders.ExternalShader;
import com.stencyl.graphics.shaders.InlineShader;
import com.stencyl.graphics.shaders.BlurShader;
import com.stencyl.graphics.shaders.SharpenShader;
import com.stencyl.graphics.shaders.ScanlineShader;
import com.stencyl.graphics.shaders.CSBShader;
import com.stencyl.graphics.shaders.HueShader;
import com.stencyl.graphics.shaders.TintShader;
import com.stencyl.graphics.shaders.BloomShader;



class ActorEvents_59 extends ActorScript
{
	public var _GolemHealth:Float;
	
	
	public function new(dummy:Int, actor:Actor, dummy2:Engine)
	{
		super(actor);
		nameMap.set("GolemHealth", "_GolemHealth");
		_GolemHealth = 0.0;
		
	}
	
	override public function init()
	{
		
		/* ======================== When Creating ========================= */
		actor.growTo(150/100, 150/100, .35, Linear.easeNone);
		_GolemHealth = asNumber(15);
		propertyChanged("_GolemHealth", _GolemHealth);
		if((_GolemHealth == 0))
		{
			recycleActor(actor);
		}
		
		/* ======================== Actor of Type ========================= */
		addCollisionListener(actor, function(event:Collision, list:Array<Dynamic>):Void
		{
			if(wrapper.enabled && sameAsAny(getActorType(19), event.otherActor.getType(),event.otherActor.getGroup()))
			{
				_GolemHealth = asNumber((_GolemHealth - 1));
				propertyChanged("_GolemHealth", _GolemHealth);
				actor.setXVelocity(0);
				actor.setYVelocity(0);
				recycleActor(actor.getLastCollidedActor());
			}
		});
		
		/* ======================= Every N seconds ======================== */
		runPeriodically(1000 * .4, function(timeTask:TimedTask):Void
		{
			if(wrapper.enabled)
			{
				actor.applyImpulse((Engine.engine.getGameAttribute("Wizzy1X") - actor.getXCenter()), (Engine.engine.getGameAttribute("Wizzy1Y") - actor.getYCenter()), 2.5);
				if((Engine.engine.getGameAttribute("Wizzy1X") < actor.getXCenter()))
				{
					actor.setAnimation("" + "Walk Down");
				}
				else if((Engine.engine.getGameAttribute("Wizzy1X") > actor.getXCenter()))
				{
					actor.setAnimation("" + "Walk Up");
				}
				if((Engine.engine.getGameAttribute("Wizzy1Y") > actor.getYCenter()))
				{
					actor.setAnimation("" + "Walk Left");
				}
				else if((Engine.engine.getGameAttribute("Wizzy1Y") < actor.getYCenter()))
				{
					actor.setAnimation("" + "Walk Right");
				}
			}
		}, actor);
		
	}
	
	override public function forwardMessage(msg:String)
	{
		
	}
}