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

#define CHOOSE_YOUR_BRAWLER_POSITION CGPointMake(0, 400)

#define START_GAME_SIZE CGSizeMake(300, 150)
#define START_GAME_POSITION CGPointMake(0, -200)

#define BILLY_SELECT_IMAGE_NAME @"BillySelect"
#define BILLY_SELECT_SIZE CGSizeMake(100, 100)
#define BILLY_SELECT_POSITION CGPointMake(-150, 300)

#define STEVE_SELECT_IMAGE_NAME @"SteveSelect"
#define STEVE_SELECT_SIZE CGSizeMake(100, 100)
#define STEVE_SELECT_POSITION CGPointMake(0, 300)

#define ABBY_SELECT_IMAGE_NAME @"AbbySelect"
#define ABBY_SELECT_SIZE CGSizeMake(100, 100)
#define ABBY_SELECT_POSITION CGPointMake(150, 300)

#define HARRY_SELECT_IMAGE_NAME @"HarrySelect"
#define HARRY_SELECT_SIZE CGSizeMake(100, 100)
#define HARRY_SELECT_POSITION CGPointMake(-150, 150)

#define SELECT_BORDER_IMAGE_NAME @"SelectBorder"
#define SELECT_BORDER_SIZE CGSizeMake(100, 100)

@interface MenuScene : SKScene

@property (nonatomic) SceneManager *sceneManager;

@property (nonatomic) SKSpriteNode *window;
@property (nonatomic) SKSpriteNode *startGameButton;

@property (nonatomic) SKLabelNode *chooseYourBrawlerLabel;

@property (nonatomic) int brawlerSelection;
@property (nonatomic) SKSpriteNode *billySelect;
- (void) billySelectPressed;
@property (nonatomic) SKSpriteNode *steveSelect;
- (void) steveSelectPressed;
@property (nonatomic) SKSpriteNode *abbySelect;
- (void) abbySelectPressed;
@property (nonatomic) SKSpriteNode *harrySelect;
- (void) harrySelectPressed;

@property (nonatomic) SKSpriteNode *selectBorder;

@end

#endif /* MenuScene_h */
