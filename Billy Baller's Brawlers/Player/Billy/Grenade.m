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
#import "CategoryDefinitions.h"

@implementation Grenade {

}

+ (instancetype)grenadeAt:(CGPoint)point going:(Direction)direction isOpponents:(BOOL)isOpponents {

	Grenade *grenade = [Grenade spriteNodeWithImageNamed:@"Grenade"];
	
	[grenade setPosition:point];
	[grenade setSize:GRENADE_SIZE];
	
	grenade.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:GRENADE_SIZE.width/2];
	grenade.physicsBody.categoryBitMask = grenadeCategory;
	grenade.physicsBody.collisionBitMask = 0x0;
	grenade.physicsBody.contactTestBitMask = opponentCategory;
	grenade.physicsBody.node.name = grenadeName;
	grenade.physicsBody.affectedByGravity = NO;
	grenade.physicsBody.dynamic = YES;
	grenade.name = grenadeName;
	
	grenade.isOpponents = isOpponents;
	if (isOpponents) {
		grenade.name = [grenadeName stringByAppendingString:OPPONENT_POSTFIX];
	}
	
	CGFloat totalDistance;
	
	SKAction * motion;
	CGFloat newY = -500;
	if (direction == North) {
		totalDistance = abs((int)(newY - point.y));
		motion = [SKAction moveTo:CGPointMake(point.x, newY) duration:totalDistance/GRENADE_SPEED];
	} else if (direction == South) {
		newY *= -1;
		totalDistance = abs((int)(newY - point.y));
		motion = [SKAction moveTo:CGPointMake(point.x, newY) duration:totalDistance/GRENADE_SPEED];
	}
	
	SKAction *onDestroyAction = [SKAction performSelector:@selector(explode) onTarget:grenade];
	SKAction *sequence = [SKAction sequence:@[motion, onDestroyAction]];
	
	[grenade runAction:sequence];
	
	return grenade;
	
}

- (void) explode {
	// Spawn Explosion
	Explosion *explosion = [Explosion explosionAt:self.position withDuration:EXPLOSION_DURATAION isOpponents:_isOpponents];
	[self.parent addChild:explosion];
	[self removeFromParent];
}

@end





