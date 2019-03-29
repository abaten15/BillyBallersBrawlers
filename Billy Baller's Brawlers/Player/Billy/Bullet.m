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

@implementation Bullet {

}

+ (instancetype) bulletAt:(CGPoint)point going:(Direction)direction {

	Bullet *bullet = [Bullet spriteNodeWithImageNamed:@"Bullet"];
	
	[bullet setPosition:point];
	[bullet setSize:BULLET_SIZE];
	
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
	
}\

@end






