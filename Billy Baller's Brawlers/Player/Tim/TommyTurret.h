//
//  TommyTurret.h
//  Billy Baller's Brawlers
//
//  Created by Nick Abate on 5/12/19.
//  Copyright © 2019 Nick Abate. All rights reserved.
//

#ifndef TommyTurret_h
#define TommyTurret_h

#import <SpriteKit/SpriteKit.h>

#import "Direction.h"

#define TOMMY_TURRET_IMAGE_NAME @"TommyTurret"
#define TOMMY_TURRET_SIZE CGSizeMake(50,50)
#define TOMMY_TURRET_SHOOTING_OFFSET CGPointMake(0, 40)
#define TOMMY_TURRET_SHOOTING_COOLDOWN 0.3
#define TOMMY_TURRET_BULLET_COUNT 6
#define TOMMY_TURRET_BULLET_DAMAGE 20

@interface TommyTurret : SKSpriteNode

@property (nonatomic) BOOL isOpponents;
+ (instancetype) turretAt:(CGPoint)point isOpponents:(BOOL)isOpponentsIn;

@property (nonatomic) int shotCount;
- (void) shootBullet;

@end

#endif /* TommyTurret_h */
