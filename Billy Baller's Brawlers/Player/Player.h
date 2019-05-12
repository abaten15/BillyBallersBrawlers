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
#import "CooldownManager.h"
#import "GameScene.h"
@class GameScene;

#define PLAYER_POSITION CGPointMake(0, -500)
#define PLAYER_SIZE CGSizeMake(100, 100)

#define PLAYER_POSTFIX @"player"
#define OPPONENT_POSTFIX @"opponent"

#define OPPONENT_PREFIX @"opponentID"

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
#define STEVE_SHOOTING_OFFSET CGPointMake(45, 45)
#define STEVE_MAIN_COOLDOWN .15
#define STEVE_SPECIAL_COOLDOWN 3
#define STEVE_MAX_HEALTH 100

#define ABBY_ID 2
#define ABBY_IMAGE_NAME @"Abby"
#define ABBY_SPEED 35.0
#define ABBY_SHOOTING_OFFSET CGPointMake(45, 45)
#define ABBY_MAIN_COOLDOWN .3
#define ABBY_SPECIAL_COOLDOWN 2.5
#define ABBY_MAX_HEALTH 90

#define HARRY_ID 3
#define HARRY_IMAGE_NAME @"Harry"
#define HARRY_SPEED 30.0
#define HARRY_SHOOTING_OFFSET CGPointMake(50, 50)
#define HARRY_MAIN_COOLDOWN 1.25
#define HARRY_SPECIAL_COOLDOWN 4.0
#define HARRY_MAX_HEALTH 110

#define TIM_ID 4
#define TIM_IMAGE_NAME @"Tim"
#define TIM_SPEED 35.0
#define TIM_SHOOTING_OFFSET CGPointMake(50, 50)
#define TIM_MAIN_COOLDOWN 2.0
#define TIM_SPECIAL_COOLDOWN 3.0
#define TIM_MAX_HEALTH 100

@interface Player : SKSpriteNode

@property (nonatomic) BOOL isOpponent;

@property (nonatomic) int brawlerID;

@property (nonatomic) GameServicer *gameServicer;
@property (nonatomic) GameScene *gameScene;

+ (instancetype)brawlerWithID:(int)brawlerIDIn isOpponent:(BOOL)isOpponentIn withServicer:(GameServicer *)gameServicer;

@property (nonatomic) HealthBar *healthBar;
- (void) takeDamage:(int)damage;

@property (nonatomic) CGFloat mySpeed;
- (void) moveTo:(CGFloat) newX;

@property (nonatomic) CooldownManager *cooldownManager;

@property (nonatomic) CGFloat mainCooldown;
@property (nonatomic) BOOL canShootMain;
- (void) performMainAttack;
- (void) endMainCooldown;

@property (nonatomic) CGFloat specialCooldown;
@property (nonatomic) BOOL canShootSpecial;
- (void) performSpecialAttack;
- (void) endSpecialCooldown;

- (void) shootBulletAt:(CGPoint)point going:(Direction)dir;
- (void) shootThrowingStarAt:(CGPoint)point going:(Direction)dir;
- (void) shootStunBulletAt:(CGPoint)point going:(Direction)dir;
- (void) launchDroneAt:(CGPoint)point;

- (void) shootGrenadeAt:(CGPoint)point going:(Direction)dir;
- (void) shootSlimeBallAt:(CGPoint)point going:(Direction)dir;
- (void) shootSniperBulletAt:(CGPoint)point going:(Direction)dir;
- (void) shootShovelWallAt:(CGPoint)point going:(Direction)dir;

@property (nonatomic) BOOL isStunned;
- (void) getStunned;
- (void) endStun;

@property (nonatomic) BOOL flipped;
@property (nonatomic) CGPoint shootingOffset;
- (void) updateShootingOffset;
- (void) flipBrawler;

@property (nonatomic) BOOL isSlidding;

@property (nonatomic) BOOL isBouncing;
- (void) stopBouncing;
- (void) bounceTo:(CGFloat)newX takeDamage:(BOOL)shouldTakeDamage damageToTake:(int)damageToTake;

@end

#endif /* Player_h */
