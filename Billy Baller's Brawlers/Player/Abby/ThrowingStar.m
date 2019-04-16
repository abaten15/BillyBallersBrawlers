//
//  ThrowingStar.m
//  Billy Baller's Brawlers
//
//  Created by Nick Abate on 4/15/19.
//  Copyright © 2019 Nick Abate. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SpriteKit/SpriteKit.h>

#import "ThrowingStar.h"

#import "CategoryDefinitions.h"
#import "Player.h"
#import "StarPiece.h"

@implementation ThrowingStar {

}

+ (instancetype) throwingStarAt:(CGPoint)point going:(Direction)dir isOpponents:(BOOL)isOpponentsIn {

	ThrowingStar *throwingStar = [ThrowingStar spriteNodeWithImageNamed:THROWING_STAR_IMAGE_NAME];

	// Bullet init
	[throwingStar setPosition:point];
	[throwingStar setSize:THROWING_STAR_SIZE];
	[throwingStar setZPosition:1];
	
	// Bullet collision body
	throwingStar.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:THROWING_STAR_SIZE.width/2];
	throwingStar.physicsBody.categoryBitMask = throwingStarCategory;
	throwingStar.physicsBody.collisionBitMask = 0x0;
	throwingStar.physicsBody.contactTestBitMask = wallCategory | opponentCategory | playerCategory;
	throwingStar.physicsBody.node.name = throwingStarName;
	throwingStar.physicsBody.affectedByGravity = NO;
	throwingStar.physicsBody.dynamic = YES;
	throwingStar.name = throwingStarName;
	
	if (isOpponentsIn) {
		throwingStar.name = [throwingStarName stringByAppendingString:OPPONENT_POSTFIX];
	}
	
	// Actions
	CGFloat totalDistance = THROWING_STAR_GOTO_OFFSET - point.y;
	
	SKAction * motion;
	if (dir == North) {
		motion = [SKAction moveTo:CGPointMake(point.x, THROWING_STAR_GOTO_OFFSET) duration:totalDistance/THROWING_STAR_SPEED];
	} else {
		motion = [SKAction moveTo:CGPointMake(point.x, -1 * THROWING_STAR_GOTO_OFFSET) duration:totalDistance/THROWING_STAR_SPEED];
	}
	
	SKAction *onDestroyAction = [SKAction performSelector:@selector(splitStarPieces) onTarget:throwingStar];
	SKAction *sequence = [SKAction sequence:@[motion, onDestroyAction]];
	
	[throwingStar runAction:sequence];

	return throwingStar;
	
}

- (void) splitStarPieces {
	StarPiece *pieceOne = [StarPiece starPieceAt:self.position going:East isOpponents:_isOpponents];
	[self.parent addChild:pieceOne];
	StarPiece *pieceTwo = [StarPiece starPieceAt:self.position going:West isOpponents:_isOpponents];
	[self.parent addChild:pieceTwo];
	[self removeFromParent];
}

@end
