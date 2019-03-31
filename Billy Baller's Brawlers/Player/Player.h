//
//  Player.h
//  Billy Baller's Brawlers
//
//  Created by Nick Abate on 3/25/19.
//  Copyright © 2019 Nick Abate. All rights reserved.
//

#ifndef Player_h
#define Player_h

#import <SpriteKit/SpriteKit.h>

#import "HealthBar.h"

#define PLAYER_POSITION CGPointMake(0, -500)
#define PLAYER_SIZE CGSizeMake(100, 100)

#define BILLY_ID 0
#define BILLY_IMAGE_NAME @"Billy"
#define BILLY_SPEED 30.0
#define BILLY_MAIN_OFFSET CGPointMake(-40, 40)
#define BILLY_MAX_HEALTH 100

#define STEVE_ID 1
#define STEVE_IMAGE_NAME @"Steve"
#define STEVE_SPEED 30.0
#define STEVE_MAX_HEALTH 100

@interface Player : SKSpriteNode

@property (nonatomic) int brawlerID;
+ (instancetype)brawlerWithID:(int) brawlerID;

@property (nonatomic) HealthBar *healthBar;

@property (nonatomic) CGFloat mySpeed;
- (void) moveTo:(CGFloat) newX;

- (void) performMainAttack;

- (void) performSpecialAttack;

@property (nonatomic) BOOL flipped;
- (void) flipBrawler;

@end

#endif /* Player_h */