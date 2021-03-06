//
//  SceneManager.h
//  Billy Baller's Brawlers
//
//  Created by Nick Abate on 4/11/19.
//  Copyright © 2019 Nick Abate. All rights reserved.
//

#ifndef SceneManager_h
#define SceneManager_h

#import <SpriteKit/SpriteKit.h>
#import <GameplayKit/GameplayKit.h>

#import "LoadingScreen.h"
@class LoadingScreen;
#import "MenuScene.h"
@class MenuScene;
#import "GameScene.h"
@class GameScene;
#import "ProfileLoader.h"
@class ProfileLoader;

#define MENU_SCENE_ID 0
#define GAME_SCENE_ID 1

#define LOADING_SCENE_FILE_NAME @"LoadingScreen"
#define MENU_SCENE_FILE_NAME @"MenuScene"
#define GAME_SCENE_FILE_NAME @"GameScene"

#define OPENING_SCENE MENU_SCENE_ID

#define TRANSITION_FADE_DURATION 1.0

@interface SceneManager : NSObject

@property (nonatomic) int brawlerSelection;

@property (nonatomic) ProfileLoader *profileLoader;

@property (nonatomic) LoadingScreen *loadingScene;
@property (nonatomic) MenuScene *menuScene;
@property (nonatomic) GameScene *gameScene;

@property (nonatomic) int currentSceneID;
@property (nonatomic) SKScene *currentScene;

@property (nonatomic) SKView *viewForLoading;

- (id) initWithView:(SKView *)viewIn;

- (void) presentOpeningScene;
- (void) presentSceneWithID:(int)idIn;

- (void) parseJSON:(NSDictionary *)json;

@end

#endif /* SceneManager_h */
