//
//  Explosion.h
//  Billy Baller's Brawlers
//
//  Created by Nick Abate on 3/27/19.
//  Copyright © 2019 Nick Abate. All rights reserved.
//

#ifndef Explosion_h
#define Explosion_h

#include <SpriteKit/SpriteKit.h>

#define EXPLOSION_IMAGE_NAME @"Explosion"

#define EXPLOSION_SIZE CGSizeMake(200,200)

#define EXPLOSION_DURATAION 0.5

@interface Explosion : SKSpriteNode

+ (instancetype)explosionAt:(CGPoint)point withDuration:(CGFloat)duration;

@end

#endif /* Explosion_h */
