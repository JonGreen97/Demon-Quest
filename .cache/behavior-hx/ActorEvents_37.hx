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



class ActorEvents_37 extends ActorScript
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
			if(wrapper.enabled && sameAsAny(getActorType(0), event.otherActor.getType(),event.otherActor.getGroup()))
			{
				if((getCurrentSceneName() == "scene 1"))
				{
					if((actor.getAnimation() == "Idle"))
					{
						Engine.engine.setGameAttribute("Player Health", ((Engine.engine.getGameAttribute("Player Health") : Float) + 50));
						Engine.engine.setGameAttribute("HealthCarry", 1);
						actor.setAnimation("Collect");
						runLater(1000 * .4, function(timeTask:TimedTask):Void
						{
							actor.setAnimation("Collected");
						}, actor);
					}
					else if((actor.getAnimation() == "Collected"))
					{
						Engine.engine.setGameAttribute("Player Health", (Engine.engine.getGameAttribute("Player Health") : Float));
					}
				}
				if((getCurrentSceneName() == "scene 2"))
				{
					if((actor.getAnimation() == "Idle"))
					{
						Engine.engine.setGameAttribute("Player Health", ((Engine.engine.getGameAttribute("Player Health") : Float) + 50));
						Engine.engine.setGameAttribute("HealthCarry", 1);
						actor.setAnimation("Collect");
						runLater(1000 * .4, function(timeTask:TimedTask):Void
						{
							actor.setAnimation("Collected");
						}, actor);
					}
					else if((actor.getAnimation() == "Collected"))
					{
						Engine.engine.setGameAttribute("Player Health", (Engine.engine.getGameAttribute("Player Health") : Float));
					}
				}
				if((getCurrentSceneName() == "scene 3"))
				{
					if((actor.getAnimation() == "Idle"))
					{
						Engine.engine.setGameAttribute("Player Health", ((Engine.engine.getGameAttribute("Player Health") : Float) + 50));
						Engine.engine.setGameAttribute("HealthCarry", 1);
						actor.setAnimation("Collect");
						runLater(1000 * .4, function(timeTask:TimedTask):Void
						{
							actor.setAnimation("Collected");
						}, actor);
					}
					else if((actor.getAnimation() == "Collected"))
					{
						Engine.engine.setGameAttribute("Player Health", (Engine.engine.getGameAttribute("Player Health") : Float));
					}
				}
				if((getCurrentSceneName() == "scene 4"))
				{
					if((actor.getAnimation() == "Idle"))
					{
						Engine.engine.setGameAttribute("Player Health", ((Engine.engine.getGameAttribute("Player Health") : Float) + 50));
						Engine.engine.setGameAttribute("HealthCarry", 1);
						actor.setAnimation("Collect");
						runLater(1000 * .4, function(timeTask:TimedTask):Void
						{
							actor.setAnimation("Collected");
						}, actor);
					}
				}
				else if((actor.getAnimation() == "Collected"))
				{
					Engine.engine.setGameAttribute("Player Health", (Engine.engine.getGameAttribute("Player Health") : Float));
				}
			}
		});
		
	}
	
	override public function forwardMessage(msg:String)
	{
		
	}
}