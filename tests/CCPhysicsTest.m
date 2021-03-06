//
// Click and Move demo
// a cocos2d example
// http://www.cocos2d-iphone.org
//

#import "cocos2d.h"
#import "CCPhysics.h"
#import "BaseAppController.h"

//CLASS INTERFACE
@interface AppController : BaseAppController
@end

@interface MainLayer : CCLayer
@end

@implementation MainLayer

-(void)onEnter
{
	[super onEnter];
	
	CCPhysicsNode *physicsNode = [CCPhysicsNode node];
	physicsNode.gravity = ccp(0.0, -100.0);
	[self addChild:physicsNode];
	
	CCNode *node = [CCNode node];
//	node.position = ccp(32, -63);
	node.rotation = 20;
	[physicsNode addChild:node];
	
	{
		CCSprite *sprite = [CCSprite spriteWithFile: @"blocks.png"];
		sprite.position = ccp(240, 160);
//		sprite.rotation = 45;
//		sprite.scale = 0.5;
		
		CGSize size = sprite.contentSize;
		CGRect rect = CGRectMake(0, 0, size.width, size.height);
		sprite.physicsBody = [CCPhysicsBody bodyWithRect:rect cornerRadius:0.0];
//		sprite.physicsBody.angularVelocity = 1;
		
//		sprite.position = ccp(240, 160);
		[node addChild:sprite];
	}
	
	{
		CCSprite *sprite = [CCSprite spriteWithFile: @"blocks.png"];
		sprite.position = ccp(240, 0);
		
		CGSize size = sprite.contentSize;
		CGRect rect = CGRectMake(0, 0, size.width, size.height);
		sprite.physicsBody = [CCPhysicsBody bodyWithRect:rect cornerRadius:0.0];
		sprite.physicsBody.type = kCCPhysicsBodyTypeStatic;
		
		[physicsNode addChild:sprite];
	}
}

@end

// CLASS IMPLEMENTATIONS
@implementation AppController

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
	[super application:application didFinishLaunchingWithOptions:launchOptions];

	// Turn on display FPS
	[director_ setDisplayStats:YES];

	// Enables High Res mode (Retina Display) on iPhone 4 and maintains low res on all other devices
	if( ! [director_ enableRetinaDisplay:YES] )
		CCLOG(@"Retina Display Not supported");

	// Set multiple touches on
	[[director_ view] setMultipleTouchEnabled:YES];

	[CCTexture2D setDefaultAlphaPixelFormat:kCCTexture2DPixelFormat_RGBA8888];

	CCFileUtils *sharedFileUtils = [CCFileUtils sharedFileUtils];
	[sharedFileUtils setEnableFallbackSuffixes:YES];			// Default: NO. No fallback suffixes are going to be used
	[sharedFileUtils setiPhoneRetinaDisplaySuffix:@"-hd"];		// Default on iPhone RetinaDisplay is "-hd"
	[sharedFileUtils setiPadSuffix:@"-ipad"];					// Default on iPad is "ipad"
	[sharedFileUtils setiPadRetinaDisplaySuffix:@"-ipadhd"];	// Default on iPad RetinaDisplay is "-ipadhd"

	return YES;
}

// This is needed for iOS4 and iOS5 in order to ensure
// that the 1st scene has the correct dimensions
// This is not needed on iOS6 and could be added to the application:didFinish...
-(void) directorDidReshapeProjection:(CCDirector*)director
{
	if(director.runningScene == nil){
		// Add the first scene to the stack. The director will draw it immediately into the framebuffer. (Animation is started automatically when the view is displayed.)
		CCScene *scene = [CCScene node];
		[scene addChild: [MainLayer node] ];
		[director runWithScene: scene];
	}
}

@end
