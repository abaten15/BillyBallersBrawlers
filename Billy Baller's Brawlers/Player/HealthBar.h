//
//  HealthBar.h
//  Billy Baller's Brawlers
//
//  Created by Nick Abate on 3/27/19.
//  Copyright © 2019 Nick Abate. All rights reserved.
//

#ifndef HealthBar_h
#define HealthBar_h

#import <SpriteKit/SpriteKit.h>

#import "GameServicer.h"
@class GameServicer;

#define HEALTH_BAR_IMAGE_NAME @"HealthBar"

#define HEALTH_UPDATE_PREFIX @"health-"

#define HEALTH_BAR_SIZE CGSizeMake(100, 15)
#define HEALTH_BAR_OFFSET CGPointMake(0, 75)

@interface HealthBar : SKSpriteNode

+ (instancetype) healthBarWithMaxHealth:(CGFloat)maxHealth withServicer:(GameServicer *)servicer;

@property (nonatomic) GameServicer *gameServicer;
- (void) checkData:(NSData *) data;

@property (nonatomic) int maxHealth;
@property (nonatomic) int currentHealth;
- (BOOL) takeDamage:(int) damage;

@end


#endif /* HealthBar_h */
