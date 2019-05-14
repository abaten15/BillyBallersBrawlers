//
//  ShovelWall.m
//  Billy Baller's Brawlers
//
//  Created by Nick Abate on 4/29/19.
//  Copyright © 2019 Nick Abate. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SpriteKit/SpriteKit.h>

#import "ShovelWall.h"

#import "CategoryDefinitions.h"
#import "Player.h"

@implementation ShovelWall {

}

+ (instancetype) shovelWallAt:(CGFloat)xLocation isOpponents:(BOOL)isOpponentsIn inScene:(GameScene *)gameScene{

	ShovelWall *shovelWall = [ShovelWall spriteNodeWithImageNamed:SHOVEL_WALL_IMAGE_NAME];
	
	shovelWall.isOpponents = isOpponentsIn;
	shovelWall.gameScene = gameScene;
	
	[shovelWall setSize:SHOVEL_WALL_SIZE];
	if (isOpponentsIn) {
		[shovelWall setPosition:CGPointMake(xLocation, -1 * SHOVEL_WALL_Y_LOCATION)];
	} else {
		[shovelWall setPosition:CGPointMake(xLocation, SHOVEL_WALL_Y_LOCATION)];
	}
	[shovelWall setZPosition:3];
	
	shovelWall.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:SHOVEL_WALL_SIZE];
	shovelWall.physicsBody.categoryBitMask = playerWallCategory;
	shovelWall.physicsBody.collisionBitMask = 0x0;
	shovelWall.physicsBody.contactTestBitMask = wallCategory | opponentCategory | playerCategory;
	shovelWall.physicsBody.node.name = shovelWallName;
	shovelWall.physicsBody.affectedByGravity = NO;
	shovelWall.physicsBody.dynamic = NO;
	shovelWall.name = shovelWallName;
	
	if (isOpponentsIn) {
		shovelWall.name = [shovelWallName stringByAppendingString:OPPONENT_POSTFIX];
	}
	
	SKAction *delayAction = [SKAction waitForDuration:SHOVEL_WALL_DURATION];
	SKAction *deathAction = [SKAction performSelector:@selector(death) onTarget:shovelWall];
	SKAction *sequence = [SKAction sequence:@[delayAction, deathAction]];
	
	[shovelWall runAction:sequence];
	
	return shovelWall;

}

- (void) death {
	[_gameScene.player invalidateWallLocation];
	[_gameScene.opponent invalidateWallLocation];
	[self removeFromParent];
}

@end
