//
//  MenuScene.h
//  Billy Baller's Brawlers
//
//  Created by Nick Abate on 4/11/19.
//  Copyright © 2019 Nick Abate. All rights reserved.
//

#ifndef MenuScene_h
#define MenuScene_h

#import <SpriteKit/SpriteKit.h>

#import "SceneManager.h"
@class SceneManager;

#define START_GAME_SIZE CGSizeMake(300, 150)
#define START_GAME_POSITION CGPointMake(0, -200)

@interface MenuScene : SKScene

@property (nonatomic) SceneManager *sceneManager;

@property (nonatomic) SKSpriteNode *window;
@property (nonatomic) SKSpriteNode *startGameButton;

@end

#endif /* MenuScene_h */
