//
//  ShovelPath.h
//  Billy Baller's Brawlers
//
//  Created by Nick Abate on 5/13/19.
//  Copyright © 2019 Nick Abate. All rights reserved.
//

#ifndef ShovelPath_h
#define ShovelPath_h

#import <SpriteKit/SpriteKit.h>

#import "GameScene.h"

#define SHOVEL_PATH_IMAGE_NAME @"ShovelPath"
#define SHOVEL_PATH_SIZE CGSizeMake(40, 150)
#define SHOVEL_PATH_OFFSET 130
#define SHOVEL_PATH_SPAWN_DURATION 0.025

@interface ShovelPath : SKSpriteNode

@property (nonatomic) BOOL isOpponents;
@property (nonatomic) GameScene *gameScene;
+ (instancetype) shovelPathAt:(CGPoint)point isOpponents:(BOOL)isOpponentsIn inScene:(GameScene *)gameScene;

- (void) spawnNextPath;

@end

#endif /* ShovelPath_h */
