package scripts;

import com.stencyl.graphics.G;
import com.stencyl.graphics.BitmapWrapper;
import com.stencyl.graphics.ScaleMode;

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

import com.stencyl.Config;
import com.stencyl.Engine;
import com.stencyl.Input;
import com.stencyl.Key;
import com.stencyl.utils.motion.*;
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
	public var _m:Float;
	
	
	public function new(dummy:Int, actor:Actor, dummy2:Engine)
	{
		super(actor);
		nameMap.set("GolemHealth", "_GolemHealth");
		_GolemHealth = 0.0;
		nameMap.set("m", "_m");
		_m = 0.0;
		
	}
	
	override public function init()
	{
		
		/* ======================== When Creating ========================= */
		actor.growTo(150/100, 150/100, .35, Easing.linear);
		Engine.engine.setGameAttribute("GolemHealth", 5);
		
		/* ======================== Actor of Type ========================= */
		addCollisionListener(actor, function(event:Collision, list:Array<Dynamic>):Void
		{
			if(wrapper.enabled && sameAsAny(getActorType(19), event.otherActor.getType(),event.otherActor.getGroup()))
			{
				actor.setXVelocity(0);
				actor.setYVelocity(0);
				recycleActor(actor.getLastCollidedActor());
				Engine.engine.setGameAttribute("GolemHealth", ((Engine.engine.getGameAttribute("GolemHealth") : Float) - 1));
				if(((Engine.engine.getGameAttribute("GolemHealth") : Float) <= 0))
				{
					recycleActor(actor);
				}
			}
		});
		
		/* ======================== Actor of Type ========================= */
		addCollisionListener(actor, function(event:Collision, list:Array<Dynamic>):Void
		{
			if(wrapper.enabled && sameAsAny(getActorType(55), event.otherActor.getType(),event.otherActor.getGroup()))
			{
				actor.setXVelocity(0);
				actor.setYVelocity(0);
				recycleActor(actor.getLastCollidedActor());
				Engine.engine.setGameAttribute("GolemHealth", ((Engine.engine.getGameAttribute("GolemHealth") : Float) - 2));
				if(((Engine.engine.getGameAttribute("GolemHealth") : Float) <= 0))
				{
					recycleActor(actor);
				}
			}
		});
		
		/* ======================== Actor of Type ========================= */
		addCollisionListener(actor, function(event:Collision, list:Array<Dynamic>):Void
		{
			if(wrapper.enabled && sameAsAny(getActorType(79), event.otherActor.getType(),event.otherActor.getGroup()))
			{
				actor.setXVelocity(0);
				actor.setYVelocity(0);
				recycleActor(actor.getLastCollidedActor());
				Engine.engine.setGameAttribute("GolemHealth", ((Engine.engine.getGameAttribute("GolemHealth") : Float) - 1));
				if(((Engine.engine.getGameAttribute("GolemHealth") : Float) <= 0))
				{
					recycleActor(actor);
				}
			}
		});
		
		/* ========================= When Drawing ========================= */
		addWhenDrawingListener(null, function(g:G, x:Float, y:Float, list:Array<Dynamic>):Void
		{
			if(wrapper.enabled)
			{
				g.setFont(getFont(46));
				g.translateToScreen();
				g.drawString("" + "5", actor.getX(), actor.getY());
			}
		});
		
		/* ======================= Every N seconds ======================== */
		runPeriodically(1000 * .4, function(timeTask:TimedTask):Void
		{
			if(wrapper.enabled)
			{
				_m = (((Engine.engine.getGameAttribute("Wizzy1Y") : Float) - actor.getYCenter()) / ((Engine.engine.getGameAttribute("Wizzy1X") : Float) - actor.getXCenter()));
				actor.push(((Engine.engine.getGameAttribute("Wizzy1X") : Float) - actor.getXCenter()), ((Engine.engine.getGameAttribute("Wizzy1Y") : Float) - actor.getYCenter()), 35);
				if(((_m <= 1) && (_m >= -1)))
				{
					if(((Engine.engine.getGameAttribute("Wizzy1X") : Float) < actor.getYCenter()))
					{
						actor.setAnimation("Walk Left");
					}
					else if(((Engine.engine.getGameAttribute("Wizzy1X") : Float) > actor.getYCenter()))
					{
						actor.setAnimation("Walk Right");
					}
				}
				else
				{
					if(((Engine.engine.getGameAttribute("Wizzy1Y") : Float) < actor.getXCenter()))
					{
						actor.setAnimation("Walk Down");
					}
					else if(((Engine.engine.getGameAttribute("Wizzy1Y") : Float) > actor.getXCenter()))
					{
						actor.setAnimation("Walk Up");
					}
				}
			}
		}, actor);
		
	}
	
	override public function forwardMessage(msg:String)
	{
		
	}
}