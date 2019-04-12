//
//  Slime.h
//  Billy Baller's Brawlers
//
//  Created by Nick Abate on 4/9/19.
//  Copyright © 2019 Nick Abate. All rights reserved.
//
//  NOTE: Do not make the cooldown for a slime attack shorter than the
//  duration of slime. This is both impractical (two slimes on the field
//  at once?) and will cause bugs in the code. OnRemove must be remodeled
//  if this functionality is desired.

#ifndef Slime_h
#define Slime_h

#import <SpriteKit/SpriteKit.h>

#import "Player.h"
@class Player;
#import "PlayerControls.h"
#import "GameScene.h"
@class GameScene;

#define SLIME_IMAGE_NAME @"Slime"

#define SLIME_DURATION 1.25
#define SLIME_SIZE CGSizeMake(SLIDER_MAX_X, 100)
#define SLIME_Y_OFFSET 500
#define SLIME_X_OFFSET (SLIME_SIZE.width/2)

@interface Slime : SKSpriteNode

@property (nonatomic) BOOL isOpponents;
@property (nonatomic) BOOL slidePlayerRight;
@property (nonatomic) Player *playerToSlide;
@property (nonatomic) GameScene *gameScene;
+ (instancetype) slimeAt:(CGPoint)point isOpponents:(BOOL)isOpponentsIn;

- (void) onRemoval;

@end

#endif /* Slime_h */
