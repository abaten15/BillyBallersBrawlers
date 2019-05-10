//
//  PlayerControls.h
//  Billy Baller's Brawlers
//
//  Created by Nick Abate on 3/25/19.
//  Copyright © 2019 Nick Abate. All rights reserved.
//

#ifndef PlayerControls_h
#define PlayerControls_h

#include <SpriteKit/SpriteKit.h>

#include "Player.h"
@class Player;
#include "GameServicer.h"
@class GameServicer;
#include "Direction.h"

#define SLIDER_POSITION CGPointMake(0, -500)
#define SLIDER_SIZE CGSizeMake(700, 300)
#define SLIDER_MAX_X 275
#define SLIDER_NETWORK_PREFIX @"slider"

#define MAIN_BUTTON_POSITION CGPointMake(-300, -200)
#define MAIN_BUTTON_SIZE CGSizeMake(100,100)
#define MAIN_BUTTON_NETWORK_PREFIX @"mainButton"

#define SPECIAL_BUTTON_POSITION CGPointMake(-200, -200)
#define SPECIAL_BUTTON_SIZE CGSizeMake(100,100)
#define SPECIAL_BUTTON_NETWORK_PREFIX @"specialButton"

#define FLIP_BUTTON_POSITION CGPointMake(-300, -100)
#define FLIP_BUTTON_SIZE CGSizeMake(100,100)
#define FLIP_BUTTON_NETWORK_PREFIX @"flipButton"

#define PLAYER_BOUNCE_DATA @"playerBounce"

@interface PlayerControls : SKNode

@property (nonatomic) Player *playerToControl;
@property (nonatomic) GameServicer *gameServicer;

+ (instancetype)controlsForPlayer:(Player *)playerIn withServicer:(GameServicer *) gameServicerIn;

@property (nonatomic) SKSpriteNode *slider;
- (void) sliderMotion:(CGFloat)newX sendData:(BOOL)shouldSendData;

@property (nonatomic) SKSpriteNode *mainAttackButton;
- (void) mainAttackButtonPressed:(CGPoint)point sendData:(BOOL)shouldSendData;

@property (nonatomic) SKSpriteNode *specialAttackButton;
- (void) specialAttackButtonPressed:(CGPoint)point sendData:(BOOL)shouldSendData;

@property (nonatomic) SKSpriteNode *flipBrawlerButton;
- (void) flipBrawlerButtonPressed:(CGPoint)point sendData:(BOOL)shouldSendData;

- (void) checkControlsDown:(CGPoint) point;
- (void) checkControlsMoved:(CGPoint) point;
- (void) checkControlsUp:(CGPoint) point;

- (void) performActionFromData:(NSData *)data;

- (void) slidePlayerInDirection:(Direction)dir;

@property (nonatomic) BOOL playerIsStunned;
- (void) playerGotStunned;
- (void) endPlayerStun;

@property (nonatomic) BOOL playerIsBouncingOffWall;
- (void) bouncePlayerInDirection:(Direction)dir bounceDistance:(CGFloat)bounceDistance takeDamage:(BOOL)shouldTakeDamage damageToTake:(int)damageToTake;
- (void) endPlayerBounce;
- (void) sendBounceData:(CGFloat)bounceTo;

@end

#endif /* PlayerControls_h */
