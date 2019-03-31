//
//  Wall.h
//  Billy Baller's Brawlers
//
//  Created by Nick Abate on 3/25/19.
//  Copyright © 2019 Nick Abate. All rights reserved.
//

#ifndef Wall_h
#define Wall_h

#import <SpriteKit/SpriteKit.h>

#define WALL_IMAGE_NAME @"Wall"

#define WALL_SIZE CGSizeMake(200, 80)

#define WALL_TL 0
#define WALL_TL_POS CGPointMake(-150, 360)
#define WALL_TR 1
#define WALL_TR_POS CGPointMake(150, 360)
#define WALL_BL 2
#define WALL_BL_POS CGPointMake(-150, -360)
#define WALL_BR 3
#define WALL_BR_POS CGPointMake(150, -360)

@interface Wall : SKSpriteNode

+ (instancetype)wallAtLocation:(int) ID;

@end

#endif /* Wall_h */
