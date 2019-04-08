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
@class HealthBar;
#import "GameServicer.h"
@class GameServicer;
#import "Direction.h"

#define PLAYER_POSITION CGPointMake(0, -500)
#define PLAYER_SIZE CGSizeMake(100, 100)

#define PLAYER_POSTFIX @"player"
#define OPPONENT_POSTFIX @"opponent"

#define BILLY_ID 0
#define BILLY_IMAGE_NAME @"Billy"
#define BILLY_SPEED 30.0
#define BILLY_MAIN_OFFSET CGPointMake(-45, 45)
#define BILLY_MAIN_COOLDOWN .15
#define BILLY_SPECIAL_COOLDOWN 1.5
#define BILLY_MAX_HEALTH 100

#define STEVE_ID 1
#define STEVE_IMAGE_NAME @"Steve"
#define STEVE_SPEED 30.0
#define STEVE_MAX_HEALTH 100

@interface Player : SKSpriteNode

@property (nonatomic) BOOL isOpponent;

@property (nonatomic) int brawlerID;

@property (nonatomic) GameServicer *gameServicer;

+ (instancetype)brawlerWithID:(int)brawlerID isOpponent:(BOOL)isOpponentIn withServicer:(GameServicer *)gameServicer;

@property (nonatomic) HealthBar *healthBar;
- (void) takeDamage:(int)damage;

@property (nonatomic) CGFloat mySpeed;
- (void) moveTo:(CGFloat) newX;

@property (nonatomic) CGFloat mainCooldown;
@property (nonatomic) BOOL canShootMain;
- (void) performMainAttack;
- (void) endMainCooldown;

@property (nonatomic) CGFloat specialCooldown;
@property (nonatomic) BOOL canShootSpecial;
- (void) performSpecialAttack;
- (void) endSpecialCooldown;

- (void) shootBulletAt:(CGPoint)point going:(Direction)dir;
- (void) shootGrenadeAt:(CGPoint)point going:(Direction)dir;

@property (nonatomic) BOOL flipped;
@property (nonatomic) CGPoint shootingOffset;
- (void) updateShootingOffset;
- (void) flipBrawler;

@end

#endif /* Player_h */
