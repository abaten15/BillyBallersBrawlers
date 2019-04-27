//
//  Bullet.h
//  Billy Baller's Brawlers
//
//  Created by Nick Abate on 3/26/19.
//  Copyright © 2019 Nick Abate. All rights reserved.
//

#ifndef Bullet_h
#define Bullet_h

#include <SpriteKit/SpriteKit.h>

#include "Direction.h"

#define BULLET_IMAGE_NAME @"Bullet"

#define BULLET_SIZE CGSizeMake(20,20)
#define BULLET_SPEED 1200
#define BILLY_BULLET_DAMAGE 20
#define STEVE_BULLET_DAMAGE 10

#define BULLET_GOTO_OFFSET 1600

@interface Bullet : SKSpriteNode

@property (nonatomic) int brawlerId;
@property (nonatomic) BOOL isOpponents;
+ (instancetype) bulletAt:(CGPoint)point going:(Direction)direction isOpponents:(BOOL)isOpponents;

@end

#endif /* Bullet_h */
