//
//  Wall.m
//  Billy Baller's Brawlers
//
//  Created by Nick Abate on 3/25/19.
//  Copyright © 2019 Nick Abate. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SpriteKit/SpriteKit.h>

#import "Wall.h"

#import "CategoryDefinitions.h"

@implementation Wall {

}

+ (instancetype)wallAtLocation:(int) ID {

	Wall *wall = [Wall spriteNodeWithImageNamed:WALL_IMAGE_NAME];

	switch (ID) {
	case WALL_TL:
    	[wall setPosition:WALL_TL_POS];
    	break;
	case WALL_TR:
    	[wall setPosition:WALL_TR_POS];
    	break;
	case WALL_BL:
    	[wall setPosition:WALL_BL_POS];
    	break;
	case WALL_BR:
    	[wall setPosition:WALL_BR_POS];
    	break;
	default:
    	break;
	}
	
	[wall setSize:WALL_SIZE];
	[wall setZPosition:1];
	
	wall.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:WALL_PHYSICS_SIZE];
	wall.physicsBody.categoryBitMask = wallCategory;
	wall.physicsBody.collisionBitMask = 0x0;
	wall.physicsBody.contactTestBitMask = projectileCategory;
	wall.physicsBody.node.name = wallName;
	wall.physicsBody.affectedByGravity = NO;
	wall.physicsBody.dynamic = NO;
	wall.name = wallName;

	return wall;

}

@end
