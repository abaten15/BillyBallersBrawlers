//
//  DroneArtilleryExplosion.m
//  Billy Baller's Brawlers
//
//  Created by Nick Abate on 5/12/19.
//  Copyright © 2019 Nick Abate. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SpriteKit/SpriteKit.h>

#import "DroneArtilleryExplosion.h"
#import "CategoryDefinitions.h"

@implementation DroneArtilleryExplosion {

}

+ (instancetype) droneArtilleryExplosionAt:(CGPoint)point withZPosition:(int)zPosition {

	DroneArtilleryExplosion *explosion = [DroneArtilleryExplosion spriteNodeWithImageNamed:DRONE_ARTILLERY_EXPLOSION_IMAGE_NAME];
	
	[explosion setPosition:point];
	[explosion setSize:DRONE_ARTILLERY_EXPLOSION_SIZE];
	[explosion setZPosition:zPosition];
	
	explosion.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:DRONE_ARTILLERY_EXPLOSION_SIZE.width/2];
	explosion.physicsBody.categoryBitMask = aoeCategory;
	explosion.physicsBody.collisionBitMask = 0x0;
	explosion.physicsBody.contactTestBitMask = playerCategory | opponentCategory;
	explosion.physicsBody.node.name = droneArtilleryExplosionName;
	explosion.physicsBody.affectedByGravity = NO;
	explosion.physicsBody.dynamic = NO;
	explosion.name = droneArtilleryExplosionName;
	
	SKAction *waitDurationAction = [SKAction waitForDuration:DRONE_ARTILLERY_EXPLOSION_DURATION];
	SKAction *deathAction = [SKAction performSelector:@selector(removeFromParent) onTarget:explosion];
	SKAction *sequence = [SKAction sequence:@[waitDurationAction, deathAction]];
	
	[explosion runAction:sequence];
	
	return explosion;

}

@end
