//
//  GameScene.h
//  Billy Baller's Brawlers
//
//  Created by Nick Abate on 2/6/19.
//  Copyright © 2019 Nick Abate. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import <GameplayKit/GameplayKit.h>

#import "Background.h"
#import "YouLoseAnimation.h"
#import "YouWinAnimation.h"
#import "Player.h"
@class Player;
#import "PlayerControls.h"
@class PlayerControls;
#import "CategoryDefinitions.h"
#import "GameServicer.h"
@class GameServicer;

#define JOIN_GAME_BUTTON_POSITION CGPointMake(0, -100)
#define JOIN_GAME_BUTTON_SIZE CGSizeMake(300, 150)

#define HOST_GAME_BUTTON_POSITION CGPointMake(0, 100)
#define HOST_GAME_BUTTON_SIZE CGSizeMake(300, 150)

@class Background;

@interface GameScene : SKScene <SKPhysicsContactDelegate>

@property (nonatomic) NSMutableArray<GKEntity *> *entities;
@property (nonatomic) NSMutableDictionary<NSString*, GKGraph *> *graphs;

@property (nonatomic) SKSpriteNode *window;

@property (nonatomic) BOOL gameOver;
@property (nonatomic) YouWinAnimation *youWinAnimation;
- (void) winGame;
@property (nonatomic) YouLoseAnimation *youLoseAnimation;
- (void) loseGame;

@property (nonatomic) NSMutableArray *contactQueue;
- (void) didBeginContact:(SKPhysicsContact *)contact;
- (void) handleContact:(SKPhysicsContact *)contact;

@property (nonatomic) Background *background;

@property (nonatomic) Player *player;
@property (nonatomic) PlayerControls *playerControls;

@property (nonatomic) Player *opponent;
@property (nonatomic) PlayerControls *opponentControls;
- (void) spawnOpponent;
- (void) checkOpponentData:(NSData *)data;

@property (nonatomic) GameServicer *gameServicer;
@property (nonatomic) BOOL GameStarted;
@property (nonatomic) SKSpriteNode *hostGameButton;
@property (nonatomic) SKSpriteNode *joinGameButton;

@end
