//
//  ShovelWall.h
//  Billy Baller's Brawlers
//
//  Created by Nick Abate on 4/29/19.
//  Copyright © 2019 Nick Abate. All rights reserved.
//

#ifndef ShovelWall_h
#define ShovelWall_h

#import <SpriteKit/SpriteKit.h>

#define SHOVEL_WALL_IMAGE_NAME @"ShovelWall"
#define SHOVEL_WALL_SIZE CGSizeMake(30, 100)
#define SHOVEL_WALL_Y_LOCATION 500
#define SHOVEL_WALL_DAMAGE 10
#define SHOVEL_WALL_BOUNCINESS 30
#define SHOVEL_WALL_DURATION 1.5

@interface ShovelWall : SKSpriteNode

@property (nonatomic) BOOL isOpponents;
+ (instancetype) shovelWallAt:(CGFloat)xLocation isOpponents:(BOOL)isOpponentsIn;

@end

#endif /* ShovelWall_h */
