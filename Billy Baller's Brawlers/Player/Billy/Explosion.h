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

#include "Player.h"

#define EXPLOSION_IMAGE_NAME @"Explosion"

#define EXPLOSION_SIZE CGSizeMake(250,250)

#define EXPLOSION_DURATAION 0.3

@interface Explosion : SKSpriteNode

+ (instancetype)explosionAt:(CGPoint)point withDuration:(CGFloat)duration isOpponents:(BOOL)isOpponents;

- (void) checkContact:(Player *) player;

@end

#endif /* Explosion_h */
