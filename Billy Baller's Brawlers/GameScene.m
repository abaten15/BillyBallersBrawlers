//
//  GameScene.m
//  Billy Baller's Brawlers
//
//  Created by Nick Abate on 2/6/19.
//  Copyright © 2019 Nick Abate. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

#import "GameScene.h"
#import "Background.h"

@implementation GameScene {
    NSTimeInterval _lastUpdateTime;
}

- (void)sceneDidLoad {

	_lastUpdateTime = 0;
	
	self.physicsWorld.contactDelegate = self;
	self.contactQueue = [NSMutableArray array];
	
	self.window = [SKSpriteNode spriteNodeWithTexture:NULL size:CGSizeMake(2000, 2000)];
	[self.window setPosition:CGPointMake(0, 0)];
	[self addChild:self.window];
	
	[self setBackgroundColor:[UIColor colorWithWhite:0.5 alpha:1]];
	
	_background = [Background backgroundWithImageNamed:@"Background"];
	[self addChild:_background];
	
	_player = [Player brawlerWithID:BILLY_ID];
	[_background addChild:_player];
	
	_playerControls = [PlayerControls controlsForPlayer:_player];
	[self addChild:_playerControls];
	
}

- (void) didBeginContact:(SKPhysicsContact *)contact {
	[self.contactQueue addObject:contact];
	NSLog(@"contact");
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
	NSLog(@"contact");
	NSLog(contact.bodyA.node.name);
	NSLog(contact.bodyB.node.name);
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
	[_playerControls checkControlsDown:point];
}
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
	UITouch *touch = [touches anyObject];
	CGPoint point = [touch locationInNode:self.window];
	[_playerControls checkControlsMoved:point];
}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
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
