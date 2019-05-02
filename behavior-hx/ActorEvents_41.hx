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



class ActorEvents_41 extends ActorScript
{
	public var _FireHit:Bool;
	public var _BossAttack:Float;
	
	
	public function new(dummy:Int, actor:Actor, dummy2:Engine)
	{
		super(actor);
		nameMap.set("FireHit", "_FireHit");
		_FireHit = false;
		nameMap.set("BossAttack", "_BossAttack");
		_BossAttack = 0.0;
		
	}
	
	override public function init()
	{
		
		/* ======================== When Creating ========================= */
		actor.growTo(200/100, 200/100, 2.5, Quad.easeInOut);
		Engine.engine.setGameAttribute("Boss health", 500);
		_BossAttack = asNumber(2.5);
		propertyChanged("_BossAttack", _BossAttack);
		
		/* ======================= Every N seconds ======================== */
		runPeriodically(1000 * .25, function(timeTask:TimedTask):Void
		{
			if(wrapper.enabled)
			{
				if((Engine.engine.getGameAttribute("Boss health") <= 200))
				{
					_BossAttack = asNumber(1);
					propertyChanged("_BossAttack", _BossAttack);
					actor.setAnimation("" + "Phase 2");
				}
				if((Engine.engine.getGameAttribute("Boss health") <= 0))
				{
					recycleActor(actor);
					Engine.engine.setGameAttribute("BossFight", false);
				}
			}
		}, actor);
		
		/* ======================= Every N seconds ======================== */
		runPeriodically(1000 * _BossAttack, function(timeTask:TimedTask):Void
		{
			if(wrapper.enabled)
			{
				if((actor.getAnimation() == "Phase 1"))
				{
					createRecycledActor(getActorType(47), actor.getX(), actor.getY(), Script.FRONT);
					getLastCreatedActor().applyImpulse((Engine.engine.getGameAttribute("Wizzy1X") - actor.getX()), (Engine.engine.getGameAttribute("Wizzy1Y") - actor.getY()), 15);
				}
				if((actor.getAnimation() == "Phase 2"))
				{
					createRecycledActor(getActorType(47), actor.getX(), actor.getY(), Script.FRONT);
					getLastCreatedActor().applyImpulse((Engine.engine.getGameAttribute("Wizzy1X") - actor.getX()), (Engine.engine.getGameAttribute("Wizzy1Y") - actor.getY()), 30);
					createRecycledActor(getActorType(47), (actor.getX() - 90), actor.getY(), Script.FRONT);
					getLastCreatedActor().applyImpulse((Engine.engine.getGameAttribute("Wizzy1X") - actor.getX()), (Engine.engine.getGameAttribute("Wizzy1Y") - actor.getY()), 30);
					createRecycledActor(getActorType(47), (actor.getX() + 90), actor.getY(), Script.FRONT);
					getLastCreatedActor().applyImpulse((Engine.engine.getGameAttribute("Wizzy1X") - actor.getX()), (Engine.engine.getGameAttribute("Wizzy1Y") - actor.getY()), 30);
				}
			}
		}, actor);
		
		/* ======================== Specific Actor ======================== */
		addWhenKilledListener(actor, function(list:Array<Dynamic>):Void
		{
			if(wrapper.enabled)
			{
				createRecycledActor(getActorType(51), actor.getX(), actor.getY(), Script.FRONT);
				createRecycledActor(getActorType(77), actor.getX(), actor.getY(), Script.FRONT);
			}
		});
		
		/* ========================= When Drawing ========================= */
		addWhenDrawingListener(null, function(g:G, x:Float, y:Float, list:Array<Dynamic>):Void
		{
			if(wrapper.enabled)
			{
				g.setFont(getFont(46));
				g.translateToScreen();
				g.drawString("" + Engine.engine.getGameAttribute("Boss health"), actor.getX(), actor.getY());
			}
		});
		
	}
	
	override public function forwardMessage(msg:String)
	{
		
	}
}