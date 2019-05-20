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



class ActorEvents_0 extends ActorScript
{
	public var _firespeed:Float;
	public var _walkingspeed:Float;
	public var _direction:String;
	public var _ismoving:Bool;
	
	
	public function new(dummy:Int, actor:Actor, dummy2:Engine)
	{
		super(actor);
		nameMap.set("fire speed", "_firespeed");
		_firespeed = 30.0;
		nameMap.set("walking speed", "_walkingspeed");
		_walkingspeed = 12.5;
		nameMap.set("direction", "_direction");
		_direction = "";
		nameMap.set("is moving", "_ismoving");
		_ismoving = false;
		
	}
	
	override public function init()
	{
		
		/* ======================== When Creating ========================= */
		actor.makeAlwaysSimulate();
		if((Engine.engine.getGameAttribute("HealthCarry") == 1))
		{
			Engine.engine.setGameAttribute("Player Health", Engine.engine.getGameAttribute("Player Health"));
		}
		else
		{
			Engine.engine.setGameAttribute("Player Health", 100);
		}
		if((Engine.engine.getGameAttribute("Is Transitioning") == true))
		{
			actor.setMass(900);
		}
		else if((Engine.engine.getGameAttribute("Is Transitioning") == false))
		{
			actor.setMass(1);
		}
		if((getCurrentSceneName() == "Testing Chamber"))
		{
			Engine.engine.setGameAttribute("Player Health", 500);
		}
		
		/* ========================= When Drawing ========================= */
		addWhenDrawingListener(null, function(g:G, x:Float, y:Float, list:Array<Dynamic>):Void
		{
			if(wrapper.enabled)
			{
				g.setFont(getFont(46));
				g.translateToScreen();
				g.drawString("" + Engine.engine.getGameAttribute("Player Health"), actor.getXCenter(), (actor.getYCenter() - (actor.getHeight())));
			}
		});
		
		/* ======================= Every N seconds ======================== */
		runPeriodically(1000 * 1.5, function(timeTask:TimedTask):Void
		{
			if(wrapper.enabled)
			{
				Engine.engine.setGameAttribute("Wizzy1X", actor.getX());
				Engine.engine.setGameAttribute("Wizzy1Y", actor.getY());
			}
		}, actor);
		
		/* ======================== Actor of Type ========================= */
		addCollisionListener(actor, function(event:Collision, list:Array<Dynamic>):Void
		{
			if(wrapper.enabled && sameAsAny(getActorType(35), event.otherActor.getType(),event.otherActor.getGroup()))
			{
				Engine.engine.setGameAttribute("Player Health", (Engine.engine.getGameAttribute("Player Health") - 1));
				actor.setYVelocity(0);
				actor.setXVelocity(0);
				if((Engine.engine.getGameAttribute("Player Health") <= 0))
				{
					recycleActor(actor);
				}
			}
		});
		
		/* ======================== Actor of Type ========================= */
		addCollisionListener(actor, function(event:Collision, list:Array<Dynamic>):Void
		{
			if(wrapper.enabled && sameAsAny(getActorType(47), event.otherActor.getType(),event.otherActor.getGroup()))
			{
				Engine.engine.setGameAttribute("Player Health", (Engine.engine.getGameAttribute("Player Health") - 10));
				recycleActor(actor.getLastCollidedActor());
				actor.setYVelocity(0);
				actor.setXVelocity(0);
				if((Engine.engine.getGameAttribute("Boss health") <= 200))
				{
					Engine.engine.setGameAttribute("Player Health", (Engine.engine.getGameAttribute("Player Health") - 20));
				}
				if((Engine.engine.getGameAttribute("Player Health") <= 0))
				{
					recycleActor(actor);
				}
			}
		});
		
		/* ======================= Member of Group ======================== */
		addCollisionListener(actor, function(event:Collision, list:Array<Dynamic>):Void
		{
			if(wrapper.enabled && sameAsAny(getActorGroup(8),event.otherActor.getType(),event.otherActor.getGroup()))
			{
				actor.setXVelocity(0);
				actor.setYVelocity(0);
			}
		});
		
		/* =========================== Keyboard =========================== */
		addKeyStateListener("action1", function(pressed:Bool, released:Bool, list:Array<Dynamic>):Void
		{
			if(wrapper.enabled && pressed)
			{
				playSound(getSound(81));
				if((actor.getAnimation() == "Walking Down Start"))
				{
					createRecycledActor(getActorType(79), actor.getX(), actor.getY(), Script.FRONT);
					getLastCreatedActor().setYVelocity(_firespeed);
				}
				if((actor.getAnimation() == "Idle Down Start"))
				{
					createRecycledActor(getActorType(79), actor.getX(), actor.getY(), Script.FRONT);
					getLastCreatedActor().setYVelocity(_firespeed);
				}
				if((actor.getAnimation() == "Walking Up Start"))
				{
					createRecycledActor(getActorType(79), actor.getX(), actor.getY(), Script.FRONT);
					getLastCreatedActor().setYVelocity(-(_firespeed));
				}
				if((actor.getAnimation() == "Idle Up Start"))
				{
					createRecycledActor(getActorType(79), actor.getX(), actor.getY(), Script.FRONT);
					getLastCreatedActor().setYVelocity(-(_firespeed));
				}
				if((actor.getAnimation() == "Walking Right Start"))
				{
					createRecycledActor(getActorType(79), actor.getX(), actor.getY(), Script.FRONT);
					getLastCreatedActor().setXVelocity(_firespeed);
				}
				if((actor.getAnimation() == "Idle Right Start"))
				{
					createRecycledActor(getActorType(79), actor.getX(), actor.getY(), Script.FRONT);
					getLastCreatedActor().setXVelocity(_firespeed);
				}
				if((actor.getAnimation() == "Walking Left Start"))
				{
					createRecycledActor(getActorType(79), (actor.getX() - (actor.getWidth())), actor.getY(), Script.BACK);
					getLastCreatedActor().setXVelocity(-(_firespeed));
				}
				if((actor.getAnimation() == "Idle Left Start"))
				{
					createRecycledActor(getActorType(79), (actor.getX() - (actor.getWidth())), actor.getY(), Script.BACK);
					getLastCreatedActor().setXVelocity(-(_firespeed));
				}
			}
		});
		
		/* ======================== When Updating ========================= */
		addWhenUpdatedListener(null, function(elapsedTime:Float, list:Array<Dynamic>):Void
		{
			if(wrapper.enabled)
			{
				if((actor.getYVelocity() == 0))
				{
					if(isKeyDown("left"))
					{
						actor.setAnimation("" + "Walking Left Start");
						_direction = "left";
						propertyChanged("_direction", _direction);
						actor.setXVelocity(-(_walkingspeed));
					}
					else if(isKeyDown("right"))
					{
						actor.setAnimation("" + "Walking Right Start");
						_direction = "right";
						propertyChanged("_direction", _direction);
						actor.setXVelocity(_walkingspeed);
					}
					else
					{
						actor.setXVelocity(0);
						if((_direction == "left"))
						{
							actor.setAnimation("" + "Idle Left Start");
						}
						else if((_direction == "right"))
						{
							actor.setAnimation("" + "Idle Right Start");
						}
					}
				}
				if((actor.getXVelocity() == 0))
				{
					if(isKeyDown("down"))
					{
						actor.setAnimation("" + "Walking Down Start");
						actor.setYVelocity(_walkingspeed);
						_direction = "down";
						propertyChanged("_direction", _direction);
					}
					else if(isKeyDown("up"))
					{
						actor.setAnimation("" + "Walking Up Start");
						actor.setYVelocity(-(_walkingspeed));
						_direction = "up";
						propertyChanged("_direction", _direction);
					}
					else
					{
						actor.setYVelocity(0);
						if((_direction == "up"))
						{
							actor.setAnimation("" + "Idle Up Start");
						}
						else if((_direction == "down"))
						{
							actor.setAnimation("" + "Idle Down Start");
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