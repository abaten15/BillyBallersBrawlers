//
//  DroneArtillery.m
//  Billy Baller's Brawlers
//
//  Created by Nick Abate on 5/12/19.
//  Copyright © 2019 Nick Abate. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SpriteKit/SpriteKit.h>

#import "DroneArtillery.h"
#import "DroneArtilleryExplosion.h"

@implementation DroneArtillery {

}

+ (instancetype) droneArtilleryAt:(CGPoint)point withZPosition:(int)zPositionIn {
	
	DroneArtillery *artillery = [DroneArtillery spriteNodeWithImageNamed:DRONE_ARTILLERY_IMAGE_NAME];
	
	artillery.zPositionForExplosion = zPositionIn;
	
	[artillery setSize:DRONE_ARTILLERY_SIZE];
	[artillery setPosition:point];
	
	SKAction *action = [SKAction moveToX:(point.x + DRONE_ARTILLERY_FALL_OFFSET) duration:(DRONE_ARTILLERY_FALL_OFFSET/DRONE_ARTILLERY_FALL_SPEED)];
	SKAction *explodeAction = [SKAction performSelector:@selector(explode) onTarget:artillery];
	
	SKAction *sequence = [SKAction sequence:@[action, explodeAction]];
	[artillery runAction:sequence];
	
	return artillery;
	
}

- (void) explode {
	
	DroneArtilleryExplosion *explosion = [DroneArtilleryExplosion droneArtilleryExplosionAt:self.position withZPosition:self.zPositionForExplosion];
	[self.parent addChild:explosion];
	[self removeFromParent];
	
}

@end
