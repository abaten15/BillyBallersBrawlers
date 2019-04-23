//
//  SlimeBall.m
//  Billy Baller's Brawlers
//
//  Created by Nick Abate on 4/9/19.
//  Copyright © 2019 Nick Abate. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SpriteKit/SpriteKit.h>

#import "SlimeBall.h"

#import "Direction.h"
#import "CategoryDefinitions.h"
#import "Player.h"
#import "Slime.h"

@implementation SlimeBall

+ (instancetype) slimeBallAt:(CGPoint)point going:(Direction)dir isOpponents:(BOOL)isOpponentsIn {

	SlimeBall *ball = [SlimeBall spriteNodeWithImageNamed:SLIME_BALL_IMAGE_NAME];
	
	[ball setPosition:point];
	[ball setSize:SLIME_BALL_SIZE];
	[ball setZPosition:2];

	ball.isOpponents = isOpponentsIn;
	
	CGFloat totalDistance;
	
	SKAction * motion;
	CGFloat newY = -500;
	if (dir == North) {
		totalDistance = abs((int)(newY - point.y));
		motion = [SKAction moveTo:CGPointMake(point.x, newY) duration:totalDistance/SLIME_BALL_SPEED];
	} else if (dir == South) {
		newY *= -1;
		totalDistance = abs((int)(newY - point.y));
		motion = [SKAction moveTo:CGPointMake(point.x, newY) duration:totalDistance/SLIME_BALL_SPEED];
	}
	
	SKAction *onDestroyAction = [SKAction performSelector:@selector(explode) onTarget:ball];
	SKAction *sequence = [SKAction sequence:@[motion, onDestroyAction]];
	
	[ball runAction:sequence];
	
	return ball;

}

- (void) explode {
	Slime *slime = [Slime slimeAt:self.position isOpponents:_isOpponents];
	slime.gameScene = self.gameScene;
	[self.parent addChild:slime];
	[self removeFromParent];
}

@end
