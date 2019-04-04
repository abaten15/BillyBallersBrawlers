//
//  GameServicer.h
//  Billy Baller's Brawlers
//
//  Created by Nick Abate on 4/2/19.
//  Copyright © 2019 Nick Abate. All rights reserved.
//

#ifndef GameServicer_h
#define GameServicer_h

#import <MultipeerConnectivity/MultipeerConnectivity.h>
#import <SpriteKit/SpriteKit.h>

#import "GameScene.h"
@class GameScene;

#define GAME_SERVICE_TYPE @"game-service"

@interface GameServicer : NSObject <MCNearbyServiceAdvertiserDelegate, MCNearbyServiceBrowserDelegate, MCSessionDelegate>

@property (nonatomic) MCPeerID *myPeerID;

//@property (nonatomic) MCNearbyServiceAdvertiser *serviceAdvertiser;
@property (nonatomic) MCAdvertiserAssistant *advertiserAssistant;
@property (nonatomic) MCNearbyServiceBrowser *serviceBrowser;

@property (nonatomic) GameScene *gameScene;

- (id) initWithScene:(GameScene *)gameSceneIn;

@property (nonatomic) BOOL sessionConnected;
@property (nonatomic) MCSession *gameSession;

- (void) sendData:(NSString *)data;

- (void) hostGame;
- (void) joinGame;

@end

#endif /* GameServicer_h */
