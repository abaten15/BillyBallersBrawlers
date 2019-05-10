//
//  LoadingScrene.m
//  Billy Baller's Brawlers
//
//  Created by Nick Abate on 4/28/19.
//  Copyright © 2019 Nick Abate. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SpriteKit/SpriteKit.h>

#import "LoadingScreen.h"

@implementation LoadingScreen {

}

- (void) sceneDidLoad {
	
	_loadingImage = [SKSpriteNode spriteNodeWithImageNamed:LOADING_SCREEN_IMAGE_NAME];
	[_loadingImage setPosition:CGPointMake(0, 0)];
	[_loadingImage setSize:LOADING_SCREEN_SIZE];
	[self addChild:_loadingImage];
	
	_preparingLabel = [SKLabelNode labelNodeWithText:@"Preparing The Arena..."];
	[_preparingLabel setPosition:PREPARING_LABEL_POSITION];
	[_preparingLabel setFontName:@"AvenirNext-Bold"];
	[_preparingLabel setFontSize:50];
	[_preparingLabel setFontColor:[UIColor colorWithWhite:0 alpha:1]];
	[self addChild:_preparingLabel];
	
}

- (void) loadingDelay {
	[_sceneManager performSelector:@selector(presentSceneWithID:) withObject:MENU_SCENE_ID afterDelay:LOADING_SCREEN_DELAY];
}

- (void) touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {

}

- (void) update:(NSTimeInterval)currentTime {

}

@end
