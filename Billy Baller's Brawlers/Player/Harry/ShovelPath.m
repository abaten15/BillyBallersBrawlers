//
//  ShovelPath.m
//  Billy Baller's Brawlers
//
//  Created by Nick Abate on 5/13/19.
//  Copyright © 2019 Nick Abate. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SpriteKit/SpriteKit.h>

#import "ShovelPath.h"
#import "ShovelWall.h"

@implementation ShovelPath {

}

+ (instancetype) shovelPathAt:(CGPoint)point isOpponents:(BOOL)isOpponentsIn {

	ShovelPath *shovelPath = [ShovelPath spriteNodeWithImageNamed:SHOVEL_PATH_IMAGE_NAME];
	
	shovelPath.isOpponents = isOpponentsIn;
	
	[shovelPath setPosition:point];
	[shovelPath setSize:SHOVEL_PATH_SIZE];
	[shovelPath setZPosition:0];
	
	if (isOpponentsIn) {
		[shovelPath setYScale:-1];
	}
	
	SKAction *waitForSpawnAction = [SKAction waitForDuration:SHOVEL_PATH_SPAWN_DURATION];
	SKAction *spawnNextPathAction = [SKAction performSelector:@selector(spawnNextPath) onTarget:shovelPath];
	SKAction *waitForDeathAction = [SKAction waitForDuration:(SHOVEL_PATH_SPAWN_DURATION * 3)];
	SKAction *deathAction = [SKAction performSelector:@selector(removeFromParent) onTarget:shovelPath];
	SKAction *sequence = [SKAction sequence:@[waitForSpawnAction, spawnNextPathAction, waitForDeathAction, deathAction]];
	
	[shovelPath runAction:sequence];
	
	return shovelPath;

}

- (void) spawnNextPath {

	CGPoint nextSpawnLocation = CGPointMake(self.position.x, self.position.y + SHOVEL_PATH_OFFSET);
	if (_isOpponents) {
		nextSpawnLocation = CGPointMake(self.position.x, self.position.y - SHOVEL_PATH_OFFSET);
	}
	
	BOOL spawnShovelWall = NO;
	if ((_isOpponents && nextSpawnLocation.y <= -500) ||
		(!_isOpponents && nextSpawnLocation.y >= 500)) {
		spawnShovelWall = YES;
	}
	if (spawnShovelWall) {
		ShovelWall *shovelWall = [ShovelWall shovelWallAt:self.position.x isOpponents:_isOpponents];
		[self.parent addChild:shovelWall];
	} else {
		ShovelPath *shovelPath = [ShovelPath shovelPathAt:nextSpawnLocation isOpponents:_isOpponents];
		[self.parent addChild:shovelPath];
	}
	
}

@end
