//
//  Explosion.m
//  Billy Baller's Brawlers
//
//  Created by Nick Abate on 3/27/19.
//  Copyright © 2019 Nick Abate. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SpriteKit/SpriteKit.h>

#import "Explosion.h"

#import "CategoryDefinitions.h"
#import "Player.h"
#import "Grenade.h"

@implementation Explosion

+ (instancetype) explosionAt:(CGPoint)point withDuration:(CGFloat)duration isOpponents:(BOOL)isOpponents {

	Explosion *explosion = [Explosion spriteNodeWithImageNamed:EXPLOSION_IMAGE_NAME];
	
	[explosion setZPosition:3];

	explosion.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:EXPLOSION_SIZE.width/2];
	explosion.physicsBody.categoryBitMask = aoeCategory;
	explosion.physicsBody.collisionBitMask = 0x0;
	explosion.physicsBody.contactTestBitMask = playerCategory | opponentCategory;
	explosion.physicsBody.node.name = explosionName;
	explosion.physicsBody.affectedByGravity = NO;
	explosion.physicsBody.dynamic = NO;
	explosion.name = explosionName;

	if (isOpponents) {
		explosion.name = [explosionName stringByAppendingString:OPPONENT_POSTFIX];
	}
	
	[explosion setPosition:point];
	[explosion setSize:EXPLOSION_SIZE];
	
	SKAction *delay = [SKAction waitForDuration:duration];
	SKAction *destroyAction = [SKAction performSelector:@selector(removeFromParent) withObject:self];
	SKAction *finalAction = [SKAction sequence:@[delay, destroyAction]];
	[explosion runAction:finalAction];
	
	return explosion;

}

- (void) checkContact:(Player *)player {
	if ([self containsPoint:player.position]) {
		[player takeDamage:GRENADE_DAMAGE];
	}
}

@end
