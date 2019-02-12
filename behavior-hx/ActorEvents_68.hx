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



class ActorEvents_68 extends ActorScript
{
	public var _direction:String;
	public var _walkingspeed:Float;
	public var _SkullHealth:Float;
	
	
	public function new(dummy:Int, actor:Actor, dummy2:Engine)
	{
		super(actor);
		nameMap.set("direction", "_direction");
		_direction = "";
		nameMap.set("walking speed", "_walkingspeed");
		_walkingspeed = 12.5;
		nameMap.set("SkullHealth", "_SkullHealth");
		_SkullHealth = 0.0;
		
	}
	
	override public function init()
	{
		
		/* ======================== When Creating ========================= */
		_SkullHealth = asNumber(3);
		propertyChanged("_SkullHealth", _SkullHealth);
		
		/* ======================= Every N seconds ======================== */
		runPeriodically(1000 * 1, function(timeTask:TimedTask):Void
		{
			if(wrapper.enabled)
			{
				if((randomInt(Math.floor(1), Math.floor(4)) == 1))
				{
					Engine.engine.setGameAttribute("SkullCharge", 1);
				}
				else if((randomInt(Math.floor(1), Math.floor(4)) == 2))
				{
					Engine.engine.setGameAttribute("SkullCharge", 2);
				}
				else if((randomInt(Math.floor(1), Math.floor(4)) == 3))
				{
					Engine.engine.setGameAttribute("SkullCharge", 3);
				}
				else if((randomInt(Math.floor(1), Math.floor(4)) == 4))
				{
					Engine.engine.setGameAttribute("SkullCharge", 4);
				}
				if((Engine.engine.getGameAttribute("SkullCharge") == 1))
				{
					actor.setAnimation("" + "Float Left");
					actor.setXVelocity(-5);
					runLater(1000 * .5, function(timeTask:TimedTask):Void
					{
						actor.setXVelocity(0);
						actor.setYVelocity(0);
					}, actor);
				}
				else if((Engine.engine.getGameAttribute("SkullCharge") == 2))
				{
					actor.setAnimation("" + "Float Right");
					actor.setXVelocity(5);
					runLater(1000 * .5, function(timeTask:TimedTask):Void
					{
						actor.setXVelocity(0);
						actor.setYVelocity(0);
					}, actor);
				}
				else if((Engine.engine.getGameAttribute("SkullCharge") == 3))
				{
					actor.setAnimation("" + "Float Up");
					actor.setYVelocity(-5);
					runLater(1000 * .5, function(timeTask:TimedTask):Void
					{
						actor.setXVelocity(0);
						actor.setYVelocity(0);
					}, actor);
				}
				else if((Engine.engine.getGameAttribute("SkullCharge") == 4))
				{
					actor.setAnimation("" + "Float Down");
					actor.setYVelocity(5);
					runLater(1000 * .5, function(timeTask:TimedTask):Void
					{
						actor.setXVelocity(0);
						actor.setYVelocity(0);
					}, actor);
				}
				if((Engine.engine.getGameAttribute("Wizzy1Y") <= actor.getY()))
				{
					actor.setAnimation("" + "Rush Left");
					actor.applyImpulseInDirection(270, 15);
				}
				else if((Engine.engine.getGameAttribute("Wizzy1Y") >= actor.getY()))
				{
					actor.setAnimation("" + "Rush Right");
					actor.applyImpulseInDirection(90, 15);
				}
				else if((Engine.engine.getGameAttribute("Wizzy1X") <= actor.getX()))
				{
					actor.setAnimation("" + "Rush Up");
					actor.applyImpulseInDirection(0, 15);
				}
				else if((Engine.engine.getGameAttribute("Wizzy1X") >= actor.getX()))
				{
					actor.setAnimation("" + "Rush Down");
					actor.applyImpulseInDirection(180, 15);
				}
			}
		}, actor);
		
		/* ========================= When Drawing ========================= */
		addWhenDrawingListener(null, function(g:G, x:Float, y:Float, list:Array<Dynamic>):Void
		{
			if(wrapper.enabled)
			{
				g.drawString("" + randomInt(Math.floor(1), Math.floor(4)), actor.getX(), actor.getY());
			}
		});
		
		/* ======================== Actor of Type ========================= */
		addCollisionListener(actor, function(event:Collision, list:Array<Dynamic>):Void
		{
			if(wrapper.enabled && sameAsAny(getActorType(19), event.otherActor.getType(),event.otherActor.getGroup()))
			{
				recycleActor(actor.getLastCollidedActor());
				_SkullHealth = asNumber((_SkullHealth - 1));
				propertyChanged("_SkullHealth", _SkullHealth);
				if((_SkullHealth <= 0))
				{
					actor.setAnimation("" + "Explode");
					runLater(1000 * .5, function(timeTask:TimedTask):Void
					{
						recycleActor(actor);
					}, actor);
				}
			}
		});
		
		/* ======================== Actor of Type ========================= */
		addCollisionListener(actor, function(event:Collision, list:Array<Dynamic>):Void
		{
			if(wrapper.enabled && sameAsAny(getActorType(55), event.otherActor.getType(),event.otherActor.getGroup()))
			{
				recycleActor(actor.getLastCollidedActor());
				_SkullHealth = asNumber((_SkullHealth - 2));
				propertyChanged("_SkullHealth", _SkullHealth);
				if((_SkullHealth <= 0))
				{
					actor.setAnimation("" + "Explode");
					runLater(1000 * .5, function(timeTask:TimedTask):Void
					{
						recycleActor(actor);
					}, actor);
				}
			}
		});
		
		/* ======================== Actor of Type ========================= */
		addCollisionListener(actor, function(event:Collision, list:Array<Dynamic>):Void
		{
			if(wrapper.enabled && sameAsAny(getActorType(57), event.otherActor.getType(),event.otherActor.getGroup()))
			{
				recycleActor(actor.getLastCollidedActor());
				_SkullHealth = asNumber((_SkullHealth - 3));
				propertyChanged("_SkullHealth", _SkullHealth);
				if((_SkullHealth <= 0))
				{
					actor.setAnimation("" + "Explode");
					runLater(1000 * .5, function(timeTask:TimedTask):Void
					{
						recycleActor(actor);
					}, actor);
				}
			}
		});
		
	}
	
	override public function forwardMessage(msg:String)
	{
		
	}
}