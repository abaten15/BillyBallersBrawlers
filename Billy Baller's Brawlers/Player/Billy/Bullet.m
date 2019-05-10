//
//  Bullet.m
//  Billy Baller's Brawlers
//
//  Created by Nick Abate on 3/26/19.
//  Copyright © 2019 Nick Abate. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SpriteKit/SpriteKit.h>

#import "Bullet.h"

#import "Direction.h"
#import "CategoryDefinitions.h"
#import "Player.h"

@implementation Bullet {

}

+ (instancetype) bulletAt:(CGPoint)point going:(Direction)direction isOpponents:(BOOL)isOpponents {

	Bullet *bullet = [Bullet spriteNodeWithImageNamed:@"Bullet"];
	
	bullet.isOpponents = isOpponents;
	
	// Bullet init
	[bullet setPosition:point];
	[bullet setSize:BULLET_SIZE];
	[bullet setZPosition:1];
	
	// Bullet collision body
	bullet.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:BULLET_SIZE.width/2];
	bullet.physicsBody.categoryBitMask = projectileCategory;
	bullet.physicsBody.collisionBitMask = 0x0;
	bullet.physicsBody.contactTestBitMask = opponentCategory | playerCategory | wallCategory;
	bullet.physicsBody.node.name = bulletName;
	bullet.physicsBody.affectedByGravity = NO;
	bullet.physicsBody.dynamic = NO;
	bullet.name = bulletName;
	
	if (isOpponents) {
		bullet.name = [bulletName stringByAppendingString:OPPONENT_POSTFIX];
		bullet.physicsBody.node.name = [bulletName stringByAppendingString:OPPONENT_POSTFIX];
	}
	
	// Actions
	CGFloat totalDistance = BULLET_GOTO_OFFSET - point.y;
	
	SKAction * motion;
	if (direction == North) {
		motion = [SKAction moveTo:CGPointMake(point.x, point.y + totalDistance) duration:totalDistance/BULLET_SPEED];
	} else {
		motion = [SKAction moveTo:CGPointMake(point.x, point.y - totalDistance) duration:totalDistance/BULLET_SPEED];
	}
	
	SKAction *onDestroyAction = [SKAction performSelector:@selector(removeFromParent) onTarget:bullet];
	SKAction *sequence = [SKAction sequence:@[motion, onDestroyAction]];
	
	[bullet runAction:sequence];
	
	return bullet;
	
}

@end






