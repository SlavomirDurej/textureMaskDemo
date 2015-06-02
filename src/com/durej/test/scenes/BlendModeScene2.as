package com.durej.test.scenes
{
	import flash.utils.setTimeout;
	import com.greensock.easing.Quad;
	import com.greensock.TweenMax;
	import starling.core.Starling;
	import starling.display.BlendMode;
	import starling.display.Button;
	import starling.display.Image;
	import starling.events.Event;
	import starling.extensions.PDParticleSystem;
	import starling.text.TextField;
	import starling.textures.Texture;

	import com.durej.test.Constants;
	import com.durej.test.Game;

	import flash.display3D.Context3DBlendFactor;

	public class BlendModeScene2 extends Scene
	{
		[Embed(source="../../../../../assets/particle.pex", mimeType="application/octet-stream")]
		public static const ParticlesConfig				: Class;

		[Embed(source = "../../../../../assets/particle.png")]
		public static const ParticleGFX					: Class;
				
		private var ps 						: PDParticleSystem;
		public var psConfig 				: XML;
		public var psTexture 				: Texture;
		private var mButton 				: Button;
		private var mImage 					: Image;
		private var mImage2					: Image;
		private var mInfoText 				: TextField;
		private var mBlendModes 			: Array = [BlendMode.NORMAL, BlendMode.BELOW, BlendMode.MULTIPLY, BlendMode.SCREEN, BlendMode.ADD, BlendMode.ERASE, BlendMode.NONE];
		private var idx 					: int = 0;
		private var idx1 					: int = 0;
		private var idx2					: int = 0;
		private var Context3DBlendFactors 	: Array = new Array(Context3DBlendFactor.ZERO, Context3DBlendFactor.ONE, Context3DBlendFactor.SOURCE_COLOR, Context3DBlendFactor.ONE_MINUS_SOURCE_COLOR, Context3DBlendFactor.SOURCE_ALPHA, Context3DBlendFactor.ONE_MINUS_SOURCE_ALPHA, Context3DBlendFactor.DESTINATION_ALPHA, Context3DBlendFactor.ONE_MINUS_DESTINATION_ALPHA, Context3DBlendFactor.DESTINATION_COLOR, Context3DBlendFactor.ONE_MINUS_DESTINATION_COLOR);
		

		public function BlendModeScene2()
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
			addChild(mImage);
			
			mImage.blendMode = BlendMode.ERASE;
			

			
			psConfig 			= XML(new ParticlesConfig());
			psTexture 			= Texture.fromBitmap(new ParticleGFX());
			
			ps 					= new PDParticleSystem(psConfig, psTexture);
			ps.x 				= 0;
			ps.y 				= 0;
			ps.startSize 		*= 1; 
			ps.endSize 			*= 1; 
			ps.endSizeVariance 	*= 1;
			this.addChild(ps);
			
			Starling.juggler.add(ps);
			
			
			var wid		: int = mImage.width / 2;
			var hei 	: int = mImage.height / 2;
			
			ps.emitterX = Constants.CenterX ;
			ps.emitterY = mImage.y +  mImage.height / 2 ;

			ps.emitterXVariance = wid;	
			ps.emitterYVariance = hei;
			
			ps.blendMode = BlendMode.BELOW;
			
			
			ps.blendFactorSource = Context3DBlendFactor.ONE_MINUS_DESTINATION_ALPHA;
			ps.blendFactorDestination = Context3DBlendFactor.ONE; //destinationAlpha, one
			
			trace(ps.blendFactorSource);
			trace(ps.blendFactorDestination);
		
						//add image
			mImage2 = new Image(Game.assets.getTexture("starling_rocket"));
			mImage2.x = mImage.x;
			mImage2.y = mImage.y;
			addChild(mImage2);
			
			mImage2.blendMode = BlendMode.BELOW;				
		
			
		}

		private function initGFX() : void
		{
			mButton = new Button(Game.assets.getTexture("button_normal"), "Fade");
			mButton.x = int(Constants.CenterX - mButton.width / 2);
			mButton.y = 15;
			mButton.addEventListener(Event.TRIGGERED, onButtonTriggered);
			addChild(mButton);



			/*mInfoText = new TextField(300, 32, "", "Verdana", 19);
			mInfoText.x = 10;
			mInfoText.y = 330;
			addChild(mInfoText);*/

		}

		private function reset() : void
		{
			mImage.alpha = 1;
			mImage2.alpha = 1;
		}

		private function hide() : void
		{
			TweenMax.to(mImage,1,{alpha : 0, ease:Quad.easeOut});
			TweenMax.to(mImage2,1,{alpha : 0, ease:Quad.easeOut});
		}

		private function onButtonTriggered() : void
		{
			ps.start(1);
			setTimeout(hide, 500);
			
			setTimeout(reset, 2500);
			/*
			var blendMode : String = mBlendModes.shift() as String;
			mBlendModes.push(blendMode);

			mInfoText.text = blendMode;
			ps.blendMode = blendMode;*/

			//ps.blendFactorSource = Context3DBlendFactors[idx];
			//ps.blendFactorDestination = Context3DBlendFactors[idx1];
			/*ps.blendFactorSource = Context3DBlendFactors[idx1];

			//trace(ps.blendFactorSource);
			trace(ps.blendFactorSource+"\n");

			idx1++;
			if (idx1 == Context3DBlendFactors.length) idx1 = 0;
			*/
				
			/*
			if (idx1 == Context3DBlendFactors.length)
			{
				idx1 = 0;
				idx++;
				if (idx == Context3DBlendFactors.length)
				{
					idx = 0;
				}
			}*/
			
			
		}
	}
}