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

#define HEALTH_BAR_IMAGE_NAME @"HealthBar"

#define HEALTH_BAR_SIZE CGSizeMake(100, 15)
#define HEALTH_BAR_OFFSET CGPointMake(0, 75)

@interface HealthBar : SKSpriteNode

+ (instancetype) healthBarWithMaxHealth:(CGFloat)maxHealth;

@property (nonatomic) int maxHealth;
@property (nonatomic) int currentHealth;
- (void) takeDamage;

@end


#endif /* HealthBar_h */
