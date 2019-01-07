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
		Engine.engine.setGameAttribute("Player Health", 100);
		
		/* ======================= Every N seconds ======================== */
		runPeriodically(1000 * 1.5, function(timeTask:TimedTask):Void
		{
			if(wrapper.enabled)
			{
				Engine.engine.setGameAttribute("Wizzy1X", actor.getX());
				Engine.engine.setGameAttribute("Wizzy1Y", actor.getY());
			}
		}, actor);
		
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
				Engine.engine.setGameAttribute("Player Health", (Engine.engine.getGameAttribute("Player Health") - 5));
				recycleActor(actor.getLastCollidedActor());
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
			if(wrapper.enabled && sameAsAny(getActorType(37), event.otherActor.getType(),event.otherActor.getGroup()))
			{
				if((getCurrentSceneName() == "Level 1"))
				{
					if((event.otherActor.getAnimation() == "Collected"))
					{
						Engine.engine.setGameAttribute("Player Health", Engine.engine.getGameAttribute("Player Health"));
					}
				}
				if((getCurrentSceneName() == "Testing Chamber"))
				{
					if((event.otherActor.getAnimation() == "Collected"))
					{
						Engine.engine.setGameAttribute("Player Health", Engine.engine.getGameAttribute("Player Health"));
					}
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
				if((actor.getAnimation() == "Walking Down 1"))
				{
					createRecycledActor(getActorType(19), actor.getX(), actor.getY(), Script.FRONT);
					getLastCreatedActor().setYVelocity(_firespeed);
				}
				if((actor.getAnimation() == "Idle Down 1"))
				{
					createRecycledActor(getActorType(19), actor.getX(), actor.getY(), Script.FRONT);
					getLastCreatedActor().setYVelocity(_firespeed);
				}
				if((actor.getAnimation() == "Walking Up 1"))
				{
					createRecycledActor(getActorType(19), actor.getX(), actor.getY(), Script.FRONT);
					getLastCreatedActor().setYVelocity(-(_firespeed));
				}
				if((actor.getAnimation() == "Idle Up 1"))
				{
					createRecycledActor(getActorType(19), actor.getX(), actor.getY(), Script.FRONT);
					getLastCreatedActor().setYVelocity(-(_firespeed));
				}
				if((actor.getAnimation() == "Walking Right 1"))
				{
					createRecycledActor(getActorType(19), actor.getX(), actor.getY(), Script.FRONT);
					getLastCreatedActor().setXVelocity(_firespeed);
				}
				if((actor.getAnimation() == "Idle Right 1"))
				{
					createRecycledActor(getActorType(19), actor.getX(), actor.getY(), Script.FRONT);
					getLastCreatedActor().setXVelocity(_firespeed);
				}
				if((actor.getAnimation() == "Walking Left 1"))
				{
					createRecycledActor(getActorType(19), (actor.getX() - (actor.getWidth())), actor.getY(), Script.BACK);
					getLastCreatedActor().setXVelocity(-(_firespeed));
				}
				if((actor.getAnimation() == "Idle Left 1"))
				{
					createRecycledActor(getActorType(19), (actor.getX() - (actor.getWidth())), actor.getY(), Script.BACK);
					getLastCreatedActor().setXVelocity(-(_firespeed));
				}
				if((actor.getAnimation() == "Walking Down 2"))
				{
					createRecycledActor(getActorType(55), actor.getX(), actor.getY(), Script.FRONT);
					getLastCreatedActor().setYVelocity(_firespeed);
				}
				if((actor.getAnimation() == "Idle Down 2"))
				{
					createRecycledActor(getActorType(55), actor.getX(), actor.getY(), Script.FRONT);
					getLastCreatedActor().setYVelocity(_firespeed);
				}
				if((actor.getAnimation() == "Walking Up 2"))
				{
					createRecycledActor(getActorType(55), actor.getX(), actor.getY(), Script.FRONT);
					getLastCreatedActor().setYVelocity(-(_firespeed));
				}
				if((actor.getAnimation() == "Idle Up 2"))
				{
					createRecycledActor(getActorType(55), actor.getX(), actor.getY(), Script.FRONT);
					getLastCreatedActor().setYVelocity(-(_firespeed));
				}
				if((actor.getAnimation() == "Walking Right 2"))
				{
					createRecycledActor(getActorType(55), actor.getX(), actor.getY(), Script.FRONT);
					getLastCreatedActor().setXVelocity(_firespeed);
				}
				if((actor.getAnimation() == "Idle Right 2"))
				{
					createRecycledActor(getActorType(55), actor.getX(), actor.getY(), Script.FRONT);
					getLastCreatedActor().setXVelocity(_firespeed);
				}
				if((actor.getAnimation() == "Walking Left 2"))
				{
					createRecycledActor(getActorType(55), (actor.getX() - (actor.getWidth())), actor.getY(), Script.BACK);
					getLastCreatedActor().setXVelocity(-(_firespeed));
				}
				if((actor.getAnimation() == "Idle Left 2"))
				{
					createRecycledActor(getActorType(55), (actor.getX() - (actor.getWidth())), actor.getY(), Script.BACK);
					getLastCreatedActor().setXVelocity(-(_firespeed));
				}
				if((actor.getAnimation() == "Walking Down 3"))
				{
					createRecycledActor(getActorType(57), actor.getX(), actor.getY(), Script.FRONT);
					getLastCreatedActor().setYVelocity(_firespeed);
				}
				if((actor.getAnimation() == "Idle Down 3"))
				{
					createRecycledActor(getActorType(57), actor.getX(), actor.getY(), Script.FRONT);
					getLastCreatedActor().setYVelocity(_firespeed);
				}
				if((actor.getAnimation() == "Walking Up 3"))
				{
					createRecycledActor(getActorType(57), actor.getX(), actor.getY(), Script.FRONT);
					getLastCreatedActor().setYVelocity(-(_firespeed));
				}
				if((actor.getAnimation() == "Idle Up 3"))
				{
					createRecycledActor(getActorType(57), actor.getX(), actor.getY(), Script.FRONT);
					getLastCreatedActor().setYVelocity(-(_firespeed));
				}
				if((actor.getAnimation() == "Walking Right 3"))
				{
					createRecycledActor(getActorType(57), actor.getX(), actor.getY(), Script.FRONT);
					getLastCreatedActor().setXVelocity(_firespeed);
				}
				if((actor.getAnimation() == "Idle Right 3"))
				{
					createRecycledActor(getActorType(57), actor.getX(), actor.getY(), Script.FRONT);
					getLastCreatedActor().setXVelocity(_firespeed);
				}
				if((actor.getAnimation() == "Walking Left 3"))
				{
					createRecycledActor(getActorType(57), (actor.getX() - (actor.getWidth())), actor.getY(), Script.BACK);
					getLastCreatedActor().setXVelocity(-(_firespeed));
				}
				if((actor.getAnimation() == "Idle Left 3"))
				{
					createRecycledActor(getActorType(57), (actor.getX() - (actor.getWidth())), actor.getY(), Script.BACK);
					getLastCreatedActor().setXVelocity(-(_firespeed));
				}
			}
		});
		
		/* ======================== When Updating ========================= */
		addWhenUpdatedListener(null, function(elapsedTime:Float, list:Array<Dynamic>):Void
		{
			if(wrapper.enabled)
			{
				if((Engine.engine.getGameAttribute("CurrentLevel") == 1))
				{
					if((actor.getYVelocity() == 0))
					{
						if(isKeyDown("left"))
						{
							actor.setAnimation("" + "Walking Left 1");
							_direction = "left";
							propertyChanged("_direction", _direction);
							actor.setXVelocity(-(_walkingspeed));
						}
						else if(isKeyDown("right"))
						{
							actor.setAnimation("" + "Walking Right 1");
							_direction = "right";
							propertyChanged("_direction", _direction);
							actor.setXVelocity(_walkingspeed);
						}
						else
						{
							actor.setXVelocity(0);
							if((_direction == "left"))
							{
								actor.setAnimation("" + "Idle Left 1");
							}
							else if((_direction == "right"))
							{
								actor.setAnimation("" + "Idle Right 1");
							}
						}
					}
					if((actor.getXVelocity() == 0))
					{
						if(isKeyDown("down"))
						{
							actor.setAnimation("" + "Walking Down 1");
							actor.setYVelocity(_walkingspeed);
							_direction = "down";
							propertyChanged("_direction", _direction);
						}
						else if(isKeyDown("up"))
						{
							actor.setAnimation("" + "Walking Up 1");
							actor.setYVelocity(-(_walkingspeed));
							_direction = "up";
							propertyChanged("_direction", _direction);
						}
						else
						{
							actor.setYVelocity(0);
							if((_direction == "up"))
							{
								actor.setAnimation("" + "Idle Up 1");
							}
							else if((_direction == "down"))
							{
								actor.setAnimation("" + "Idle Down 1");
							}
						}
					}
				}
				if((Engine.engine.getGameAttribute("CurrentLevel") == 2))
				{
					if((actor.getYVelocity() == 0))
					{
						if(isKeyDown("left"))
						{
							actor.setAnimation("" + "Walking Left 2");
							_direction = "left";
							propertyChanged("_direction", _direction);
							actor.setXVelocity(-(_walkingspeed));
						}
						else if(isKeyDown("right"))
						{
							actor.setAnimation("" + "Walking Right 2");
							_direction = "right";
							propertyChanged("_direction", _direction);
							actor.setXVelocity(_walkingspeed);
						}
						else
						{
							actor.setXVelocity(0);
							if((_direction == "left"))
							{
								actor.setAnimation("" + "Idle Left 2");
							}
							else if((_direction == "right"))
							{
								actor.setAnimation("" + "Idle Right 2");
							}
						}
					}
					if((actor.getXVelocity() == 0))
					{
						if(isKeyDown("down"))
						{
							actor.setAnimation("" + "Walking Down 2");
							actor.setYVelocity(_walkingspeed);
							_direction = "down";
							propertyChanged("_direction", _direction);
						}
						else if(isKeyDown("up"))
						{
							actor.setAnimation("" + "Walking Up 2");
							actor.setYVelocity(-(_walkingspeed));
							_direction = "up";
							propertyChanged("_direction", _direction);
						}
						else
						{
							actor.setYVelocity(0);
							if((_direction == "up"))
							{
								actor.setAnimation("" + "Idle Up 2");
							}
							else if((_direction == "down"))
							{
								actor.setAnimation("" + "Idle Down 2");
							}
						}
					}
				}
				if((Engine.engine.getGameAttribute("CurrentLevel") == 3))
				{
					if((actor.getYVelocity() == 0))
					{
						if(isKeyDown("left"))
						{
							actor.setAnimation("" + "Walking Left 3");
							_direction = "left";
							propertyChanged("_direction", _direction);
							actor.setXVelocity(-(_walkingspeed));
						}
						else if(isKeyDown("right"))
						{
							actor.setAnimation("" + "Walking Right 3");
							_direction = "right";
							propertyChanged("_direction", _direction);
							actor.setXVelocity(_walkingspeed);
						}
						else
						{
							actor.setXVelocity(0);
							if((_direction == "left"))
							{
								actor.setAnimation("" + "Idle Left 3");
							}
							else if((_direction == "right"))
							{
								actor.setAnimation("" + "Idle Right 3");
							}
						}
					}
					if((actor.getXVelocity() == 0))
					{
						if(isKeyDown("down"))
						{
							actor.setAnimation("" + "Walking Down 3");
							actor.setYVelocity(_walkingspeed);
							_direction = "down";
							propertyChanged("_direction", _direction);
						}
						else if(isKeyDown("up"))
						{
							actor.setAnimation("" + "Walking Up 3");
							actor.setYVelocity(-(_walkingspeed));
							_direction = "up";
							propertyChanged("_direction", _direction);
						}
						else
						{
							actor.setYVelocity(0);
							if((_direction == "up"))
							{
								actor.setAnimation("" + "Idle Up 3");
							}
							else if((_direction == "down"))
							{
								actor.setAnimation("" + "Idle Down 3");
							}
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