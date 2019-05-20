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



class ActorEvents_66 extends ActorScript
{
	public var _IsTransitioning:Bool;
	
	
	public function new(dummy:Int, actor:Actor, dummy2:Engine)
	{
		super(actor);
		nameMap.set("Is Transitioning", "_IsTransitioning");
		_IsTransitioning = false;
		
	}
	
	override public function init()
	{
		
		/* ======================== When Creating ========================= */
		if((getCurrentSceneName() == "Earth Entrance"))
		{
			actor.setAnimation("" + "enter earth");
		}
		if((getCurrentSceneName() == "scene 1"))
		{
			actor.setAnimation("" + "enter left");
		}
		if((getCurrentSceneName() == "scene 2"))
		{
			if((actor.getX() >= 600))
			{
				actor.setAnimation("" + "enter right");
			}
			if((actor.getY() <= 33))
			{
				actor.setAnimation("" + "enter up");
			}
		}
		if((getCurrentSceneName() == "scene 3"))
		{
			if((actor.getY() >= 440))
			{
				actor.setAnimation("" + "enter down");
			}
			if((actor.getX() >= 600))
			{
				actor.setAnimation("" + "enter right");
			}
		}
		if((getCurrentSceneName() == "scene 4"))
		{
			if((actor.getY() <= 37))
			{
				actor.setAnimation("" + "enter boss 3");
			}
			if((actor.getX() <= 40))
			{
				actor.setAnimation("" + "enter left");
			}
			if((actor.getX() >= 600))
			{
				actor.setAnimation("" + "enter right");
			}
		}
		
		/* ======================== Actor of Type ========================= */
		addCollisionListener(actor, function(event:Collision, list:Array<Dynamic>):Void
		{
			if(wrapper.enabled && sameAsAny(getActorType(0), event.otherActor.getType(),event.otherActor.getGroup()))
			{
				recycleActor(event.otherActor);
				if((Engine.engine.getGameAttribute("Is Transitioning") == false))
				{
					Engine.engine.setGameAttribute("Is Transitioning", true);
					if((getCurrentSceneName() == "Earth Entrance"))
					{
						createActorInNextScene(getActorType(0), 580, 210, Script.MIDDLE);
						switchScene(GameModel.get().scenes.get(4).getID(), null, createCrossfadeTransition(1.5));
					}
					if((getCurrentSceneName() == "scene 1"))
					{
						createActorInNextScene(getActorType(0), 580, 270, Script.MIDDLE);
						switchScene(GameModel.get().scenes.get(5).getID(), null, createSlideLeftTransition(1.5));
					}
					if((getCurrentSceneName() == "scene 2"))
					{
						if((actor.getAnimation() == "enter up"))
						{
							createActorInNextScene(getActorType(0), 300, 410, Script.MIDDLE);
							switchScene(GameModel.get().scenes.get(6).getID(), null, createSlideUpTransition(1.5));
						}
						else if((actor.getAnimation() == "enter right"))
						{
							createActorInNextScene(getActorType(0), 63, 272, Script.MIDDLE);
							switchScene(GameModel.get().scenes.get(4).getID(), null, createSlideRightTransition(1.5));
						}
					}
					if((getCurrentSceneName() == "scene 3"))
					{
						if((actor.getAnimation() == "enter down"))
						{
							createActorInNextScene(getActorType(0), 304, 63, Script.MIDDLE);
							switchScene(GameModel.get().scenes.get(5).getID(), null, createSlideDownTransition(1.5));
						}
						else if((actor.getAnimation() == "enter right"))
						{
							createActorInNextScene(getActorType(0), 74, 206, Script.MIDDLE);
							switchScene(GameModel.get().scenes.get(7).getID(), null, createSlideRightTransition(1.5));
						}
					}
					if((getCurrentSceneName() == "scene 4"))
					{
						if((actor.getAnimation() == "enter boss 3"))
						{
							createActorInNextScene(getActorType(0), 312, 410, Script.MIDDLE);
							switchScene(GameModel.get().scenes.get(2).getID(), null, createSlideUpTransition(1.5));
						}
						else if((actor.getAnimation() == "enter left"))
						{
							createActorInNextScene(getActorType(0), 555, 208, Script.MIDDLE);
							switchScene(GameModel.get().scenes.get(6).getID(), null, createSlideLeftTransition(1.5));
						}
					}
				}
			}
		});
		
	}
	
	override public function forwardMessage(msg:String)
	{
		
	}
}