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



class ActorEvents_35 extends ActorScript
{
	
	
	public function new(dummy:Int, actor:Actor, dummy2:Engine)
	{
		super(actor);
		
	}
	
	override public function init()
	{
		
		/* ======================== When Creating ========================= */
		actor.makeAlwaysSimulate();
		
		/* ======================== Actor of Type ========================= */
		addCollisionListener(actor, function(event:Collision, list:Array<Dynamic>):Void
		{
			if(wrapper.enabled && sameAsAny(getActorType(19), event.otherActor.getType(),event.otherActor.getGroup()))
			{
				recycleActor(actor);
			}
		});
		
		/* ======================== Actor of Type ========================= */
		addCollisionListener(actor, function(event:Collision, list:Array<Dynamic>):Void
		{
			if(wrapper.enabled && sameAsAny(getActorType(0), event.otherActor.getType(),event.otherActor.getGroup()))
			{
				Engine.engine.setGameAttribute("Player Health", (Engine.engine.getGameAttribute("Player Health") - 1));
				if((Engine.engine.getGameAttribute("Player Health") <= 0))
				{
					recycleActor(actor.getLastCollidedActor());
				}
			}
		});
		
		/* ======================== When Updating ========================= */
		addWhenUpdatedListener(null, function(elapsedTime:Float, list:Array<Dynamic>):Void
		{
			if(wrapper.enabled)
			{
				if((actor.getScreenX() < 0))
				{
					actor.setX(getScreenX());
					actor.setXVelocity(0);
				}
				if((actor.getScreenY() < 0))
				{
					actor.setY(getScreenY());
					actor.setYVelocity(0);
				}
				if(((actor.getScreenX() + (actor.getWidth())) > getScreenWidth()))
				{
					actor.setX((getScreenX() + (getScreenWidth() - (actor.getWidth()))));
					actor.setXVelocity(0);
				}
				if(((actor.getScreenY() + (actor.getHeight())) > getScreenHeight()))
				{
					actor.setY((getScreenY() + (getScreenHeight() - (actor.getHeight()))));
					actor.setYVelocity(0);
				}
			}
		});
		
		/* ======================= Every N seconds ======================== */
		runPeriodically(1000 * 1.5, function(timeTask:TimedTask):Void
		{
			if(wrapper.enabled)
			{
				if((actor.getAnimation() == "Idle"))
				{
					actor.setAnimation("" + "Attack");
					actor.applyImpulse((Engine.engine.getGameAttribute("Wizzy1X") - actor.getX()), (Engine.engine.getGameAttribute("Wizzy1Y") - actor.getY()), 5);
				}
				else if((actor.getAnimation() == "Attack"))
				{
					actor.setAnimation("" + "Idle");
					actor.setXVelocity(0);
					actor.setYVelocity(0);
				}
			}
		}, actor);
		
	}
	
	override public function forwardMessage(msg:String)
	{
		
	}
}