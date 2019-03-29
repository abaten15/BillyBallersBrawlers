//
//  Background.m
//  Billy Baller's Brawlers
//
//  Created by Nick Abate on 3/25/19.
//  Copyright © 2019 Nick Abate. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SpriteKit/SpriteKit.h>

#import "Background.h"


@implementation Background {

}

+ (instancetype)backgroundWithImageNamed:(NSString *)name {
	
	Background *node = [Background spriteNodeWithImageNamed:name];
	
	[node setPosition:BACKGROUND_POSITION];
	[node setSize:BACKGROUND_SIZE];
	
	// Creating Wall Objects
	node.wallTL = [Wall wallAtLocation:WALL_TL];
	[node addChild:node.wallTL];
	node.wallTR = [Wall wallAtLocation:WALL_TR];
	[node addChild:node.wallTR];
	node.wallBL = [Wall wallAtLocation:WALL_BL];
	[node addChild:node.wallBL];
	node.wallBR = [Wall wallAtLocation:WALL_BR];
	[node addChild:node.wallBR];
	
	return node;
}

@end
