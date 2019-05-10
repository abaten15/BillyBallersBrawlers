//
//  SniperBullet.m
//  Billy Baller's Brawlers
//
//  Created by Nick Abate on 4/17/19.
//  Copyright © 2019 Nick Abate. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SpriteKit/SpriteKit.h>

#import "SniperBullet.h"

#import "CategoryDefinitions.h"
#import "Direction.h"
#import "Player.h"

@implementation SniperBullet {

}

+ (instancetype) sniperBulletAt:(CGPoint)point going:(Direction)dir isOpponents:(BOOL)isOpponentsIn {
	
	SniperBullet *sniperBullet = [SniperBullet spriteNodeWithImageNamed:SNIPER_BULLET_IMAGE_NAME];
	
	[sniperBullet setPosition:point];
	[sniperBullet setSize:SNIPER_BULLET_SIZE];
	[sniperBullet setZPosition:3];
	
	sniperBullet.isOpponents = isOpponentsIn;
	
	// Bullet collision body
	sniperBullet.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:SNIPER_BULLET_SIZE.width/2];
	sniperBullet.physicsBody.categoryBitMask = projectileCategory;
	sniperBullet.physicsBody.collisionBitMask = 0x0;
	sniperBullet.physicsBody.contactTestBitMask = wallCategory | opponentCategory | playerCategory;
	sniperBullet.physicsBody.node.name = sniperBulletName;
	sniperBullet.physicsBody.affectedByGravity = NO;
	sniperBullet.physicsBody.dynamic = NO;
	sniperBullet.name = sniperBulletName;
	
	if (isOpponentsIn) {
		sniperBullet.physicsBody.node.name = [sniperBulletName stringByAppendingString:OPPONENT_POSTFIX];
		sniperBullet.name = [sniperBulletName stringByAppendingString:OPPONENT_POSTFIX];
	}
	
	// Actions
	CGFloat totalDistance = SNIPER_BULLET_GOTO_OFFSET - point.y;
	
	SKAction * motion;
	if (dir == North) {
		motion = [SKAction moveTo:CGPointMake(point.x, 1000) duration:totalDistance/SNIPER_BULLET_SPEED];
	} else {
		totalDistance = SNIPER_BULLET_GOTO_OFFSET + point.y;
		motion = [SKAction moveTo:CGPointMake(point.x, -1000) duration:totalDistance/SNIPER_BULLET_SPEED];
	}
	
	SKAction *onDestroyAction = [SKAction performSelector:@selector(removeFromParent) onTarget:sniperBullet];
	SKAction *sequence = [SKAction sequence:@[motion, onDestroyAction]];
	
	[sniperBullet runAction:sequence];
	
	return sniperBullet;
	
}

@end
