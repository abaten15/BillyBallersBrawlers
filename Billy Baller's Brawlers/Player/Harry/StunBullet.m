//
//  StunBullet.m
//  Billy Baller's Brawlers
//
//  Created by Nick Abate on 4/28/19.
//  Copyright © 2019 Nick Abate. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SpriteKit/SpriteKit.h>

#import "StunBullet.h"

#import "CategoryDefinitions.h"
#import "Player.h"
@class Player;

@implementation StunBullet {

}

+ (instancetype) stunBulletAt:(CGPoint)point going:(Direction)direction isOpponents:(BOOL)isOpponentsIn {

	StunBullet *stunBullet = [StunBullet spriteNodeWithImageNamed:STUN_BULLET_IMAGE_NAME];
	
	[stunBullet setPosition:point];
	[stunBullet setSize:STUN_BULLET_SIZE];
	[stunBullet setZPosition:3];
	
	stunBullet.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:STUN_BULLET_SIZE];
	stunBullet.physicsBody.categoryBitMask = projectileCategory;
	stunBullet.physicsBody.collisionBitMask = 0x0;
	stunBullet.physicsBody.contactTestBitMask = wallCategory | opponentCategory | playerCategory;
	stunBullet.physicsBody.node.name = stunBulletName;
	stunBullet.physicsBody.affectedByGravity = NO;
	stunBullet.physicsBody.dynamic = NO;
	stunBullet.name = stunBulletName;
	
	if (isOpponentsIn) {
		stunBullet.name = [stunBulletName stringByAppendingString:OPPONENT_POSTFIX];
	}
	
	// Actions
	CGFloat totalDistance = STUN_BULLET_GOTO_OFFSET - point.y;
	
	SKAction * motion;
	if (direction == North) {
		motion = [SKAction moveTo:CGPointMake(point.x, STUN_BULLET_GOTO_OFFSET) duration:totalDistance/STUN_BULLET_SPEED];
	} else {
		totalDistance = STUN_BULLET_GOTO_OFFSET + point.y;
		motion = [SKAction moveTo:CGPointMake(point.x, -1 * STUN_BULLET_GOTO_OFFSET) duration:totalDistance/STUN_BULLET_SPEED];
	}
	
	SKAction *onDestroyAction = [SKAction performSelector:@selector(removeFromParent) onTarget:stunBullet];
	SKAction *sequence = [SKAction sequence:@[motion, onDestroyAction]];
	
	stunBullet.isOpponents = isOpponentsIn;
	
	[stunBullet runAction:sequence];
	
	return stunBullet;

}

@end
