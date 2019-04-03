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
#import "Grenade.h"

@implementation GameScene {
    NSTimeInterval _lastUpdateTime;
}

- (void)sceneDidLoad {

	_lastUpdateTime = 0;
	
	_opponent = NULL;
	
	_gameServicer = [[GameServicer alloc] init];
	
	_hostGameButton = [SKSpriteNode spriteNodeWithColor:[UIColor colorWithWhite:0 alpha:1] size:HOST_GAME_BUTTON_SIZE];
	[_hostGameButton setPosition:HOST_GAME_BUTTON_POSITION];
	[_hostGameButton setZPosition:1];
	[self addChild:_hostGameButton];
	SKLabelNode *hostLabel = [SKLabelNode labelNodeWithText:@"Host Game"];
	[hostLabel setFontName:@"AvenirNext-Bold"];
	[hostLabel setFontSize:40];
	[hostLabel setFontColor:[UIColor colorWithWhite:1 alpha:1]];
	[_hostGameButton addChild:hostLabel];
	_joinGameButton = [SKSpriteNode spriteNodeWithColor:[UIColor colorWithWhite:0 alpha:1] size:JOIN_GAME_BUTTON_SIZE];
	[_joinGameButton setPosition:JOIN_GAME_BUTTON_POSITION];
	[_joinGameButton setZPosition:1];
	[self addChild:_joinGameButton];
	SKLabelNode *joinLabel = [SKLabelNode labelNodeWithText:@"Join Game"];
	[joinLabel setFontName:@"AvenirNext-Bold"];
	[joinLabel setFontSize:40];
	[joinLabel setFontColor:[UIColor colorWithWhite:1 alpha:1]];
	[_joinGameButton addChild:joinLabel];
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
	
	_player = [Player brawlerWithID:BILLY_ID isOpponent:NO];
	[self addChild:_player];
	
	_playerControls = [PlayerControls controlsForPlayer:_player withServicer:_gameServicer];
	[self addChild:_playerControls];
	
}

- (void) didBeginContact:(SKPhysicsContact *)contact {
	[self.contactQueue addObject:contact];
}

- (void)processContactsForUpdate:(NSTimeInterval)currentTime {
	for (SKPhysicsContact* contact in [self.contactQueue copy]) {
		[self handleContact:contact];
        [self.contactQueue removeObject:contact];
    }
}

- (void) handleContact:(SKPhysicsContact *)contact {
	if (!contact.bodyA.node.parent || !contact.bodyB.node.parent) {
		return;
	}
	NSString *nameA = contact.bodyA.node.name;
	NSString *nameB = contact.bodyB.node.name;
	if ([nameA isEqualToString:wallName] && [nameB isEqualToString:bulletName]) {
		[contact.bodyB.node removeFromParent];
	} else if ([nameA isEqualToString:wallName] && [nameB isEqualToString:bulletName]) {
		[contact.bodyA.node removeFromParent];
	} else if ([nameA isEqualToString:playerName] || [nameB isEqualToString:playerName]) {
		if ([nameA isEqualToString:bulletName]) {
			[_player takeDamage:BULLET_DAMAGE];
			[contact.bodyA.node removeFromParent];
		} else if ([nameB isEqualToString:bulletName]) {
			[_player takeDamage:BULLET_DAMAGE];
			[contact.bodyB.node removeFromParent];
		} else if ([nameA isEqualToString:explosionName] || [nameB isEqualToString:explosionName]) {
			[_player takeDamage:GRENADE_DAMAGE];
		}
	}
	
/*
	else if (([nameB isEqualToString:playerName] && [nameA isEqualToString:bulletName]) ||
		([nameA isEqualToString:playerName] && [nameB isEqualToString:bulletName])) {
		[_player takeDamage:BULLET_DAMAGE];
	} else if (([nameA isEqualToString:playerName] && [nameA isEqualToString:explosionName]) ||
		([nameB isEqualToString:playerName] && [nameA isEqualToString:explosionName])) {
		[_player takeDamage:GRENADE_DAMAGE];
	}
*/
	
/*
	else if ([nameA isEqualToString:playerName] && [nameB isEqualToString:grenadeName]) {
		Explosion *explosion = [Explosion explosionAt:contact.bodyB.node.position withDuration:EXPLOSION_DURATAION];
		[explosion checkContact:_player];
		[self addChild:explosion];
		[contact.bodyB.node removeFromParent];
	} else if ([nameB isEqualToString:playerName] && [nameA isEqualToString:grenadeName]) {
		Explosion *explosion = [Explosion explosionAt:contact.bodyA.node.position withDuration:EXPLOSION_DURATAION];
		[explosion checkContact:_player];
		[self addChild:explosion];
		[contact.bodyA.node removeFromParent];
	}
*/

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

- (void)spawnOpponent {
	_opponent = [Player brawlerWithID:BILLY_ID isOpponent:YES];
	[self addChild:_opponent];
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
	
    if (_opponent == NULL && dt > 1.0/60.0) {
    	_lastUpdateTime = currentTime;
		if (_gameServicer.sessionConnected) {
			[self spawnOpponent];
		}
	}
    
    // Update entities
    for (GKEntity *entity in self.entities) {
        [entity updateWithDeltaTime:dt];
    }

	if (_opponent != NULL) {
		_lastUpdateTime = currentTime;
	}

}

@end
