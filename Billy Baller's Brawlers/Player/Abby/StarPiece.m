//
//  StarPiece.m
//  Billy Baller's Brawlers
//
//  Created by Nick Abate on 4/15/19.
//  Copyright © 2019 Nick Abate. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SpriteKit/SpriteKit.h>

#import "StarPiece.h"

#import "Player.h"
#import "Direction.h"
#import "CategoryDefinitions.h"

@implementation StarPiece {

}

+ (instancetype) starPieceAt:(CGPoint)point going:(Direction)dir isOpponents:(BOOL)isOpponentsIn {

	StarPiece *starPiece = [StarPiece spriteNodeWithImageNamed:STAR_PIECE_IMAGE_NAME];
	
	[starPiece setPosition:point];
	[starPiece setSize:STAR_PIECE_SIZE];
	[starPiece setZPosition:3];
	
	starPiece.isOpponents = isOpponentsIn;
	
	// Bullet collision body
	starPiece.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:STAR_PIECE_SIZE.width/2];
	starPiece.physicsBody.categoryBitMask = projectileCategory;
	starPiece.physicsBody.collisionBitMask = 0x0;
	starPiece.physicsBody.contactTestBitMask = wallCategory | opponentCategory | playerCategory;
	starPiece.physicsBody.node.name = starPieceName;
	starPiece.physicsBody.affectedByGravity = NO;
	starPiece.physicsBody.dynamic = NO;
	starPiece.name = starPieceName;
	
	if (isOpponentsIn) {
		starPiece.physicsBody.node.name = [starPieceName stringByAppendingString:OPPONENT_POSTFIX];
		starPiece.name = [starPieceName stringByAppendingString:OPPONENT_POSTFIX];
	}
	
	// Actions
	CGFloat totalDistance = STAR_PIECE_GOTO_OFFSET;
	
	SKAction * motion;
	if (dir == East) {
		motion = [SKAction moveTo:CGPointMake(point.x + totalDistance, point.y) duration:totalDistance/STAR_PIECE_SPEED];
	} else {
		starPiece.xScale *= -1;
		motion = [SKAction moveTo:CGPointMake(point.x - totalDistance, point.y) duration:totalDistance/STAR_PIECE_SPEED];
	}
	
	SKAction *onDestroyAction = [SKAction performSelector:@selector(removeFromParent) onTarget:starPiece];
	SKAction *sequence = [SKAction sequence:@[motion, onDestroyAction]];
	
	[starPiece runAction:sequence];
	
	return starPiece;
	
}

@end
