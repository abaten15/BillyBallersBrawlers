//
//  SceneManager.m
//  Billy Baller's Brawlers
//
//  Created by Nick Abate on 4/11/19.
//  Copyright © 2019 Nick Abate. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SpriteKit/SpriteKit.h>
#import <GameplayKit/GameplayKit.h>

#import "SceneManager.h"

#import "MenuScene.h"
@class MenuScene;
#import "GameScene.h"
@class GameScene;

#import "ProfileLoader.h"

@implementation SceneManager {

}

- (id) initWithView:(SKView *)viewIn {

	self = [super init];
	
	self.viewForLoading = viewIn;
	
	_profileLoader = [[ProfileLoader alloc] init];
	
	GKScene *loadingScene = [GKScene sceneWithFileNamed:LOADING_SCENE_FILE_NAME];
	GKScene *menuScene = [GKScene sceneWithFileNamed:MENU_SCENE_FILE_NAME];
	GKScene *gameScene = [GKScene sceneWithFileNamed:GAME_SCENE_FILE_NAME];
	
	LoadingScreen *loadingScreenObj = (LoadingScreen *)loadingScene.rootNode;
	MenuScene *menuSceneObj = (MenuScene *)menuScene.rootNode;
	GameScene *gameSceneObj = (GameScene *)gameScene.rootNode;
	loadingScreenObj.sceneManager = self;
	loadingScreenObj.scaleMode = SKSceneScaleModeAspectFill;
	menuSceneObj.sceneManager = self;
	menuSceneObj.scaleMode = SKSceneScaleModeAspectFill;
	gameSceneObj.sceneManager = self;
	gameSceneObj.scaleMode = SKSceneScaleModeAspectFill;
	
	self.loadingScene = loadingScreenObj;
	self.menuScene = menuSceneObj;
	self.gameScene = gameSceneObj;
	
	[self.loadingScene loadingDelay];
	
	self.brawlerSelection = BILLY_ID;
	
	return self;
}

- (void) presentOpeningScene {
	[_viewForLoading presentScene:_loadingScene];
}

- (void) presentSceneWithID:(int)idIn {
	SKTransition *transition = [SKTransition fadeWithDuration:TRANSITION_FADE_DURATION];
	if (idIn == MENU_SCENE_ID) {
		[_viewForLoading presentScene:_menuScene transition:transition];
	} else if (idIn == GAME_SCENE_ID) {
		[_gameScene spawnPlayer:_menuScene.brawlerSelection];
		[_viewForLoading presentScene:_gameScene transition:transition];
	}
}

- (void) parseJSON:(NSDictionary *)json {

}

@end
