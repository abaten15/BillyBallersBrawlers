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
#include "GameServicer.h"

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

@interface PlayerControls : SKNode

@property (nonatomic) Player *playerToControl;
@property (nonatomic) GameServicer *gameServicer;

+ (instancetype)controlsForPlayer:(Player *)playerIn withServicer:(GameServicer *) gameServicerIn;

@property (nonatomic) SKSpriteNode *slider;
- (void) sliderMotion:(CGFloat) newX;

@property (nonatomic) SKSpriteNode *mainAttackButton;
- (void) mainAttackButtonPressed:(CGPoint) point;

@property (nonatomic) SKSpriteNode *specialAttackButton;
- (void) specialAttackButtonPressed:(CGPoint) point;

@property (nonatomic) SKSpriteNode *flipBrawlerButton;
- (void) flipBrawlerButtonPressed:(CGPoint) point;

- (void) checkControlsDown:(CGPoint) point;
- (void) checkControlsMoved:(CGPoint) point;
- (void) checkControlsUp:(CGPoint) point;

@end

#endif /* PlayerControls_h */
