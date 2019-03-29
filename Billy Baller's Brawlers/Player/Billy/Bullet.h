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

#define BULLET_GOTO_OFFSET 1600

@interface Bullet : SKSpriteNode

+ (instancetype) bulletAt:(CGPoint)point going:(Direction)direction;

@end

#endif /* Bullet_h */
