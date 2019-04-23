//
//  SniperBullet.h
//  Billy Baller's Brawlers
//
//  Created by Nick Abate on 4/17/19.
//  Copyright © 2019 Nick Abate. All rights reserved.
//

#ifndef SniperBullet_h
#define SniperBullet_h

#import <SpriteKit/SpriteKit.h>

#import "Direction.h"

#define SNIPER_BULLET_IMAGE_NAME @"SniperBullet"

#define SNIPER_BULLET_SIZE CGSizeMake(8,20)
#define SNIPER_BULLET_SPEED 3000
#define SNIPER_BULLET_DAMAGE 35
#define SNIPER_BULLET_GOTO_OFFSET 1600

@interface SniperBullet : SKSpriteNode

@property (nonatomic) BOOL isOpponents;
+ (instancetype) sniperBulletAt:(CGPoint)point going:(Direction)dir isOpponents:(BOOL)isOpponentsIn;

@end

#endif /* SniperBullet_h */
