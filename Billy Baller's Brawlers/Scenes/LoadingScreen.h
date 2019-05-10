//
//  LoadingScreen.h
//  Billy Baller's Brawlers
//
//  Created by Nick Abate on 4/28/19.
//  Copyright © 2019 Nick Abate. All rights reserved.
//

#ifndef LoadingScreen_h
#define LoadingScreen_h

#import <SpriteKit/SpriteKit.h>

#import "SceneManager.h"
@class SceneManager;

#define LOADING_SCREEN_IMAGE_NAME @"LoadingScreen"
#define LOADING_SCREEN_SIZE CGSizeMake(750, 1360)
#define LOADING_SCREEN_DELAY 1.5

#define PREPARING_LABEL_POSITION CGPointMake(0, -600)

@interface LoadingScreen : SKScene

@property (nonatomic) SceneManager *sceneManager;

@property (nonatomic) SKSpriteNode *loadingImage;
@property (nonatomic) SKLabelNode *preparingLabel;

- (void) loadingDelay;

@end

#endif /* LoadingScreen_h */
