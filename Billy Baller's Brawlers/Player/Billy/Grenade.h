//
//  Grenade.h
//  Billy Baller's Brawlers
//
//  Created by Nick Abate on 3/26/19.
//  Copyright © 2019 Nick Abate. All rights reserved.
//

#ifndef Grenade_h
#define Grenade_h

#include <SpriteKit/SpriteKit.h>

#include "Direction.h"
#include "Explosion.h"

#define GRENADE_IMAGE_NAME @"GRENADE"

#define GRENADE_SIZE CGSizeMake(20,20)
#define GRENADE_SPEED 1200
#define GRENADE_DAMAGE 10

#define GRENADE_GOTO_OFFSET 500

@interface Grenade : SKSpriteNode

+ (instancetype)grenadeAt:(CGPoint)point going:(Direction)direction;

- (void) explode;

@end

#endif /* Grenade_h */
