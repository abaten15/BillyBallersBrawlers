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
#import "SceneManager.h"
@class SceneManager;

#define JOIN_GAME_BUTTON_POSITION CGPointMake(0, -100)
#define JOIN_GAME_BUTTON_SIZE CGSizeMake(300, 150)

#define HOST_GAME_BUTTON_POSITION CGPointMake(0, 100)
#define HOST_GAME_BUTTON_SIZE CGSizeMake(300, 150)

@class Background;

@interface GameScene : SKScene <SKPhysicsContactDelegate>

@property (nonatomic) NSMutableArray<GKEntity *> *entities;
@property (nonatomic) NSMutableDictionary<NSString*, GKGraph *> *graphs;

@property (nonatomic) SKSpriteNode *window;

@property (nonatomic) SceneManager *sceneManager;

@property (nonatomic) BOOL gameOver;
@property (nonatomic) YouWinAnimation *youWinAnimation;
- (void) winGame;
@property (nonatomic) YouLoseAnimation *youLoseAnimation;
- (void) loseGame;

@property (nonatomic) NSMutableArray *contactQueue;
- (void) didBeginContact:(SKPhysicsContact *)contact;
- (void) handleContact:(SKPhysicsContact *)contact;

- (void) checkWallContacts:(SKPhysicsContact *)contact checkingName:(NSString *)nameToCheck isNameA:(BOOL)isNameA;

- (void) checkBulletContact:(SKPhysicsContact *)contact checkingName:(NSString *)nameToCheck isNameA:(BOOL)isNameA;
- (void) checkThrowingStarContact:(SKPhysicsContact *)contact checkingName:(NSString *)nameToCheck isNameA:(BOOL)isNameA;
- (void) checkStarPieceContact:(SKPhysicsContact *)contact checkingName:(NSString *)nameToCheck isNameA:(BOOL)isNameA;
- (void) checkStunBulletContact:(SKPhysicsContact *)contact checkingName:(NSString *)nameToCheck isNameA:(BOOL)isNameA;

- (void) checkExplosionContact:(SKPhysicsContact *)contact checkingName:(NSString *)nameToCheck isNameA:(BOOL)isNameA;
- (void) checkSlimeContact:(NSString *)nameToCheck atPoint:(CGPoint)point;
- (void) checkSniperBulletContact:(SKPhysicsContact *)contact checkingName:(NSString *)nameToCheck isNameA:(BOOL)isNameA;
- (void) checkShovelWallContact:(SKPhysicsContact *)contact checkingName:(NSString *)nameToCheck isNameA:(BOOL)isNameA;

@property (nonatomic) Background *background;

@property (nonatomic) Player *player;
@property (nonatomic) PlayerControls *playerControls;
- (void) spawnPlayer:(int)brawlerIdIn;

@property (nonatomic) Player *opponent;
@property (nonatomic) PlayerControls *opponentControls;
- (BOOL) spawnOpponent:(NSData *)data;
- (void) checkOpponentData:(NSData *)data;
@property (nonatomic) int playerDataSentCount;
- (void) sendPlayerID;

@property (nonatomic) BOOL isHost;
@property (nonatomic) GameServicer *gameServicer;
@property (nonatomic) BOOL GameStarted;
@property (nonatomic) SKSpriteNode *hostGameButton;
@property (nonatomic) SKSpriteNode *joinGameButton;

- (void) unslidePlayer:(BOOL)isOpponent;

@end
