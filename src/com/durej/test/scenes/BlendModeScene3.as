package com.durej.test.scenes
{
	import starling.display.Sprite;
	import starling.core.Starling;
	import starling.display.BlendMode;
	import starling.display.Button;
	import starling.display.Image;
	import starling.events.Event;
	import starling.extensions.PDParticleSystem;
	import starling.extensions.TextureMask;
	import starling.text.TextField;
	import starling.textures.Texture;

	import com.durej.test.Constants;
	import com.durej.test.Game;

	import flash.display3D.Context3DBlendFactor;

	public class BlendModeScene3 extends Scene
	{
		[Embed(source="../../../../../assets/particle.pex", mimeType="application/octet-stream")]
		public static const ParticlesConfig				: Class;

		[Embed(source = "../../../../../assets/particle.png")]
		public static const ParticleGFX					: Class;
				
		private var ps 									: PDParticleSystem;
		public var psConfig 							: XML;
		public var psTexture 							: Texture;
		private var mButton 							: Button;
		private var mImage 								: Image;

		public function BlendModeScene3()
		{
			initGFX(); 
			initParticles();
		}

		private function initParticles() : void
		{
			
			//add image
			mImage = new Image(Game.assets.getTexture("starling_rocket"));
			mImage.x = int(Constants.CenterX - mImage.width / 2);
			mImage.y = 170;
			//addChild(mImage);
			
			var particles : Sprite = new Sprite();
			this.addChild(particles);
			
			psConfig 			= XML(new ParticlesConfig());
			psTexture 			= Texture.fromBitmap(new ParticleGFX());
			
			ps 					= new PDParticleSystem(psConfig, psTexture);
			ps.x 				= 0;
			ps.y 				= 0;
			ps.startSize 		*= 1; 
			ps.endSize 			*= 1; 
			ps.endSizeVariance 	*= 1;
			particles.addChild(ps);
			
			Starling.juggler.add(ps);
			
			
			var wid		: int = mImage.width / 2;
			var hei 	: int = mImage.height / 2;
			
			ps.emitterX = Constants.CenterX ;
			ps.emitterY = mImage.y +  mImage.height / 2 ;

			ps.emitterXVariance = wid;	
			ps.emitterYVariance = hei;
			ps.blendMode = BlendMode.ADD;
			
			var textureMask : TextureMask = new TextureMask(Game.assets.getTexture("starling_rocket"));
			textureMask.threshold = 0.7;
			textureMask.x = mImage.x;
			textureMask.y = mImage.y;
			particles.mask = textureMask;
			
			//addChild(textureMask);
		}

		private function initGFX() : void
		{
			mButton = new Button(Game.assets.getTexture("button_normal"), "Fade");
			mButton.x = int(Constants.CenterX - mButton.width / 2);
			mButton.y = 15;
			mButton.addEventListener(Event.TRIGGERED, onButtonTriggered);
			addChild(mButton);
		}

		private function onButtonTriggered() : void
		{
			ps.start(1);
		}
	}
}