//
//  SlimeBall.h
//  Billy Baller's Brawlers
//
//  Created by Nick Abate on 4/9/19.
//  Copyright © 2019 Nick Abate. All rights reserved.
//

#ifndef SlimeBall_h
#define SlimeBall_h

#import <SpriteKit/SpriteKit.h>

#import "Direction.h"
#import "GameScene.h"

#define SLIME_BALL_IMAGE_NAME @"SlimeBall"

#define SLIME_BALL_SIZE CGSizeMake(20,20)
#define SLIME_BALL_SPEED 1200
#define SLIME_BALL_DAMAGE 10

#define SLIME_BALL_GOTO_OFFSET 500

@interface SlimeBall : SKSpriteNode

@property (nonatomic) BOOL isOpponents;
@property (nonatomic) GameScene *gameScene;
+ (instancetype) slimeBallAt:(CGPoint)point going:(Direction)dir isOpponents:(BOOL)isOpponentsIn;

- (void) explode;

@end

#endif /* SlimeBall_h */
