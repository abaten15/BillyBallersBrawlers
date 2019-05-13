//
//  Drone.m
//  Billy Baller's Brawlers
//
//  Created by Nick Abate on 5/10/19.
//  Copyright © 2019 Nick Abate. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SpriteKit/SpriteKit.h>

#import "Drone.h"

#import "DroneArtillery.h"

@implementation Drone {

}

+ (instancetype) droneAt:(CGPoint)point isOpponents:(BOOL)isOpponentsIn {

	Drone *drone = [Drone spriteNodeWithImageNamed:DRONE_IMAGE_NAME_1];
	
	drone.zPositionForExplosion = 3;
	
	[drone setPosition:point];
	[drone setSize:DRONE_SIZE];
	[drone setZPosition:4];
	
	CGFloat totalDistanceLeft = point.x - DRONE_OFF_SCREEN_X;
	
	SKAction *moveOffScreen = [SKAction moveToX:DRONE_OFF_SCREEN_X duration:totalDistanceLeft/DRONE_SPEED];
	CGFloat opponentsY = DRONE_OPPONENTS_Y;
	if (isOpponentsIn) {
		opponentsY *= -1;
	}
	SKAction *moveToOpponentsSide = [SKAction moveToY:opponentsY duration:0.3];
	SKAction *flipDroneAction = [SKAction performSelector:@selector(flipDrone) onTarget:drone];
	
	// Drop Locations
	CGFloat dropLocation1 = point.x - 60 - DRONE_ARTILLERY_FALL_OFFSET;
	CGFloat dropLocation2 = point.x - 20 - DRONE_ARTILLERY_FALL_OFFSET;
	CGFloat dropLocation3 = point.x + 20 - DRONE_ARTILLERY_FALL_OFFSET;
	CGFloat dropLocation4 = point.x + 60 - DRONE_ARTILLERY_FALL_OFFSET;
	
	CGFloat distanceToDrop1 = dropLocation1 - DRONE_OFF_SCREEN_X;
	CGFloat distanceToDrop2 = dropLocation2 - dropLocation1;
	CGFloat distanceToDrop3 = dropLocation3 - dropLocation2;
	CGFloat distanceToDrop4 = dropLocation4 - dropLocation3;
	CGFloat distanceToRightX = (-1 * DRONE_OFF_SCREEN_X) - dropLocation4;
	
	SKAction *moveToDropLocation1 = [SKAction moveToX:dropLocation1 duration:distanceToDrop1/DRONE_SPEED];
	SKAction *dropBombAction1 = [SKAction performSelector:@selector(dropBomb) onTarget:drone];
	SKAction *moveToDropLocation2 = [SKAction moveToX:dropLocation2 duration:distanceToDrop2/DRONE_SPEED];
	SKAction *dropBombAction2 = [SKAction performSelector:@selector(dropBomb) onTarget:drone];
	SKAction *moveToDropLocation3 = [SKAction moveToX:dropLocation3 duration:distanceToDrop3/DRONE_SPEED];
	SKAction *dropBombAction3 = [SKAction performSelector:@selector(dropBomb) onTarget:drone];
	SKAction *moveToDropLocation4 = [SKAction moveToX:dropLocation4 duration:distanceToDrop4/DRONE_SPEED];
	SKAction *dropBombAction4 = [SKAction performSelector:@selector(dropBomb) onTarget:drone];
	
	SKAction *dropArtilleryAction = [SKAction sequence:@[moveToDropLocation1, dropBombAction1, moveToDropLocation2, dropBombAction2, moveToDropLocation3, dropBombAction3, moveToDropLocation4, dropBombAction4]];
	
	SKAction *moveOffOppenentsScreen = [SKAction moveToX:(-1 * DRONE_OFF_SCREEN_X) duration:distanceToRightX/DRONE_SPEED];
	SKAction *deathAction = [SKAction performSelector:@selector(removeFromParent) onTarget:drone];
	
	SKAction *sequence = [SKAction sequence:@[moveOffScreen, moveToOpponentsSide, flipDroneAction, dropArtilleryAction, moveOffOppenentsScreen, deathAction]];
	
	[drone runAction:sequence];
	
	return drone;

}

- (void) dropBomb {
	DroneArtillery *artillery = [DroneArtillery droneArtilleryAt:self.position withZPosition:_zPositionForExplosion];
	_zPositionForExplosion = _zPositionForExplosion + 1;
	[self.parent addChild:artillery];
}

- (void) flipDrone {
	[self setXScale:(self.xScale * -1)];
}

@end
