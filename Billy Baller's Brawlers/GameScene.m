//
//  GameScene.m
//  Billy Baller's Brawlers
//
//  Created by Nick Abate on 2/6/19.
//  Copyright © 2019 Nick Abate. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import <MultipeerConnectivity/MultipeerConnectivity.h>

#import "GameScene.h"
#import "Background.h"
#import "Bullet.h"
#import "GameServicer.h"

@implementation GameScene {
    NSTimeInterval _lastUpdateTime;
}

- (void)sceneDidLoad {

	_lastUpdateTime = 0;
	
	_gameServicer = [[GameServicer alloc] init];
	_hostGameButton = [SKSpriteNode spriteNodeWithImageNamed:@"HostButton"];
	[_hostGameButton setPosition:HOST_GAME_BUTTON_POSITION];
	[_hostGameButton setSize:HOST_GAME_BUTTON_SIZE];
	[_hostGameButton setZPosition:1];
	[self addChild:_hostGameButton];
	_joinGameButton = [SKSpriteNode spriteNodeWithImageNamed:@"JoinButton"];
	[_joinGameButton setPosition:JOIN_GAME_BUTTON_POSITION];
	[_joinGameButton setSize:JOIN_GAME_BUTTON_SIZE];
	[_joinGameButton setZPosition:1];
	[self addChild:_joinGameButton];
	_GameStarted = NO;
	
	self.physicsWorld.contactDelegate = self;
	self.contactQueue = [NSMutableArray array];
	_contactQueue = [NSMutableArray array];
	SceneContactDelegate = self;
	
	self.window = [SKSpriteNode spriteNodeWithTexture:NULL size:CGSizeMake(2000, 2000)];
	[self.window setPosition:CGPointMake(0, 0)];
	[self addChild:self.window];
	
	[self setBackgroundColor:[UIColor colorWithWhite:0.5 alpha:1]];
	
	_background = [Background backgroundWithImageNamed:@"Background" addTo:self];
	[_background setZPosition:0];
	[self addChild:_background];
	
	_player = [Player brawlerWithID:BILLY_ID];
	[self addChild:_player];
	
	_playerControls = [PlayerControls controlsForPlayer:_player];
	[self addChild:_playerControls];
	
}

- (void) didBeginContact:(SKPhysicsContact *)contact {
	[self.contactQueue addObject:contact];
	NSLog(@"contact");
}

- (void)processContactsForUpdate:(NSTimeInterval)currentTime {
	for (SKPhysicsContact* contact in [self.contactQueue copy]) {
    	NSLog(@"processing contaacts");
		[self handleContact:contact];
        [self.contactQueue removeObject:contact];
    }
}

- (void) handleContact:(SKPhysicsContact *)contact {
	if (!contact.bodyA.node.parent || !contact.bodyB.node.parent) {
		return;
	}
	if ([contact.bodyA.node.name isEqualToString:wallName] && [contact.bodyB.node.name isEqualToString:bulletName]) {
		[contact.bodyB.node removeFromParent];
	} else if ([contact.bodyB.node.name isEqualToString:wallName] && [contact.bodyA.node.name isEqualToString:bulletName]) {
		[contact.bodyA.node removeFromParent];
	} else if (([contact.bodyB.node.name isEqualToString:playerName] && [contact.bodyA.node.name isEqualToString:bulletName]) ||
		([contact.bodyA.node.name isEqualToString:playerName] && [contact.bodyB.node.name isEqualToString:bulletName])) {
		[_player takeDamage:BULLET_DAMAGE];
	}
}

- (void)touchDownAtPoint:(CGPoint)pos {
}

- (void)touchMovedToPoint:(CGPoint)pos {
}

- (void)touchUpAtPoint:(CGPoint)pos {
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	UITouch *touch = [touches anyObject];
	CGPoint point = [touch locationInNode:self.window];
	if (!_GameStarted) {
		if ([_hostGameButton containsPoint:point]) {
			[_hostGameButton removeFromParent];
			[_joinGameButton removeFromParent];
			[_gameServicer hostGame];
			_GameStarted = YES;
		} else if ([_joinGameButton containsPoint:point]) {
			[_hostGameButton removeFromParent];
			[_joinGameButton removeFromParent];
			[_gameServicer joinGame];
			[_gameServicer sendData:@"joined"];
			_GameStarted = YES;
		}
		return;
	}
	[_playerControls checkControlsDown:point];
}
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
	if (!_GameStarted) {
		return;
	}
	UITouch *touch = [touches anyObject];
	CGPoint point = [touch locationInNode:self.window];
	[_playerControls checkControlsMoved:point];
}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
	if (!_GameStarted) {
		return;
	}
	UITouch *touch = [touches anyObject];
	CGPoint point = [touch locationInNode:self.window];
	[_playerControls checkControlsUp:point];
}
- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {

}


-(void)update:(CFTimeInterval)currentTime {
    // Called before each frame is rendered
    
    // Initialize _lastUpdateTime if it has not already been
    if (_lastUpdateTime == 0) {
        _lastUpdateTime = currentTime;
    }
	
    [self processContactsForUpdate:currentTime];
    
    // Calculate time since last update
    CGFloat dt = currentTime - _lastUpdateTime;
    
    // Update entities
    for (GKEntity *entity in self.entities) {
        [entity updateWithDeltaTime:dt];
    }
    
    _lastUpdateTime = currentTime;
}

@end
