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

@implementation Drone {

}

+ (instancetype) droneAt:(CGPoint)point isOpponents:(BOOL)isOpponentsIn {

	Drone *drone = [Drone spriteNodeWithImageNamed:DRONE_IMAGE_NAME_1];
	
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
	SKAction *moveToDropLocation = [SKAction moveToX:point.x duration:totalDistanceLeft/DRONE_SPEED];
	SKAction *dropBombAction = [SKAction performSelector:@selector(dropBomb) onTarget:drone];
	
	CGFloat totalDistanceRight = (-1 * DRONE_OFF_SCREEN_X) - point.x;
	
	SKAction *moveOffOppenentsScreen = [SKAction moveToX:(-1 * DRONE_OFF_SCREEN_X) duration:totalDistanceRight/DRONE_SPEED];
	SKAction *deathAction = [SKAction performSelector:@selector(removeFromParent) onTarget:drone];
	
	SKAction *sequence = [SKAction sequence:@[moveOffScreen, moveToOpponentsSide, flipDroneAction, moveToDropLocation, dropBombAction, moveOffOppenentsScreen, deathAction]];
	
	[drone runAction:sequence];
	
	return drone;

}

- (void) dropBomb {

}

- (void) flipDrone {
	[self setXScale:(self.xScale * -1)];
}

@end
