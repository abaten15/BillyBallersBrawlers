//
//  Grenade.m
//  Billy Baller's Brawlers
//
//  Created by Nick Abate on 3/26/19.
//  Copyright © 2019 Nick Abate. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SpriteKit/SpriteKit.h>

#import "Grenade.h"

#import "Direction.h"
#import "Explosion.h"

@implementation Grenade {

}

+ (instancetype)grenadeAt:(CGPoint)point going:(Direction)direction {

	Grenade *grenade = [Grenade spriteNodeWithImageNamed:@"Grenade"];
	
	[grenade setPosition:point];
	[grenade setSize:GRENADE_SIZE];
	
	CGFloat totalDistance;
	
	SKAction * motion;
	if (direction == North) {
		totalDistance = GRENADE_GOTO_OFFSET - point.y;
		motion = [SKAction moveTo:CGPointMake(point.x, point.y + totalDistance) duration:totalDistance/GRENADE_SPEED];
	} else {
		totalDistance = GRENADE_GOTO_OFFSET - point.y;
		motion = [SKAction moveTo:CGPointMake(point.x, point.y - totalDistance) duration:totalDistance/GRENADE_SPEED];
	}
	
	SKAction *onDestroyAction = [SKAction performSelector:@selector(explode) onTarget:grenade];
	SKAction *sequence = [SKAction sequence:@[motion, onDestroyAction]];
	
	[grenade runAction:sequence];
	
	return grenade;
	
}

- (void) explode {
	// Spawn Explosion
	Explosion *explosion = [Explosion explosionAt:self.position withDuration:EXPLOSION_DURATAION];
	[self.parent addChild:explosion];
	[self removeFromParent];
}

@end





