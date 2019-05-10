//
//  Slime.m
//  Billy Baller's Brawlers
//
//  Created by Nick Abate on 4/9/19.
//  Copyright © 2019 Nick Abate. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SpriteKit/SpriteKit.h>

#import "Slime.h"

#import "CategoryDefinitions.h"

@implementation Slime {

}

+ (instancetype) slimeAt:(CGPoint)point isOpponents:(BOOL)isOpponentsIn {
	
	Slime *retVal = [Slime spriteNodeWithImageNamed:SLIME_IMAGE_NAME];
	
	retVal.isOpponents = isOpponentsIn;
	if (isOpponentsIn) {
		NSLog(@"is opponents");
	} else {
		NSLog(@"is not opponents");
	}
	
	CGPoint location = CGPointMake(0, 0);
	if (point.x > 0) {
		location.x = SLIME_X_OFFSET;
	} else {
		location.x = -1 * SLIME_X_OFFSET;
	}
	if (retVal.isOpponents) {
		location.y = -1 * SLIME_Y_OFFSET;
	} else {
		location.y = SLIME_Y_OFFSET;
	}
	
	[retVal setPosition:location];
	[retVal setSize:SLIME_SIZE];
	[retVal setZPosition:1];
	
	retVal.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:SLIME_SIZE];
	retVal.physicsBody.categoryBitMask = aoeCategory;
	retVal.physicsBody.collisionBitMask = 0x0;
	retVal.physicsBody.contactTestBitMask = playerCategory | opponentCategory;
	retVal.physicsBody.node.name = slimeName;
	retVal.physicsBody.affectedByGravity = NO;
	retVal.physicsBody.dynamic = NO;
	retVal.name = slimeName;
	
	if (isOpponentsIn) {
		retVal.name = [slimeName stringByAppendingString:OPPONENT_POSTFIX];
	}
	
	SKAction *delay = [SKAction waitForDuration:SLIME_DURATION];
	SKAction *deathAction = [SKAction performSelector:@selector(onRemoval) onTarget:retVal];
	SKAction *sequence = [SKAction sequence:@[delay, deathAction]];
	[retVal runAction:sequence];
	
	return retVal;
	
}

- (void) onRemoval {
	[_gameScene unslidePlayer:(!_isOpponents)];
	[self removeFromParent];
}

@end
