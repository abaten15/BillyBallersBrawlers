//
//  MenuScene.m
//  Billy Baller's Brawlers
//
//  Created by Nick Abate on 4/11/19.
//  Copyright © 2019 Nick Abate. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SpriteKit/SpriteKit.h>

#import "MenuScene.h"

#import "Player.h"

@implementation MenuScene {

}

- (void)sceneDidLoad {
	
	_startGameButton = [SKSpriteNode spriteNodeWithColor:[UIColor colorWithWhite:0 alpha:1.0] size:START_GAME_SIZE];
	[_startGameButton setPosition:START_GAME_POSITION];
	[self addChild:_startGameButton];
	SKLabelNode *startGameLabel = [SKLabelNode labelNodeWithText:@"Start Game"];
	[startGameLabel setPosition:CGPointMake(0,0)];
	[startGameLabel setFontName:@"AvenirNext-Bold"];
	[startGameLabel setFontSize:40];
	[startGameLabel setFontColor:[UIColor colorWithWhite:1 alpha:1.0]];
	[_startGameButton addChild:startGameLabel];
	
	self.window = [SKSpriteNode spriteNodeWithTexture:NULL size:CGSizeMake(2000, 2000)];
	[self.window setPosition:CGPointMake(0, 0)];
	[self addChild:self.window];
	
	_brawlerSelection = BILLY_ID;
	
	_selectBorder = [SKSpriteNode spriteNodeWithImageNamed:SELECT_BORDER_IMAGE_NAME];
	[_selectBorder setSize:SELECT_BORDER_SIZE];
	[_selectBorder setPosition:BILLY_SELECT_POSITION];
	[_selectBorder setZPosition:2];
	[self addChild:_selectBorder];
	
	_billySelect = [SKSpriteNode spriteNodeWithImageNamed:BILLY_SELECT_IMAGE_NAME];
	[_billySelect setSize:BILLY_SELECT_SIZE];
	[_billySelect setPosition:BILLY_SELECT_POSITION];
	[_billySelect setZPosition:1];
	[self addChild:_billySelect];
	
	_steveSelect = [SKSpriteNode spriteNodeWithImageNamed:STEVE_SELECT_IMAGE_NAME];
	[_steveSelect setSize:STEVE_SELECT_SIZE];
	[_steveSelect setPosition:STEVE_SELECT_POSITION];
	[_steveSelect setZPosition:1];
	[self addChild:_steveSelect];
	
	_abbySelect = [SKSpriteNode spriteNodeWithImageNamed:ABBY_SELECT_IMAGE_NAME];
	[_abbySelect setSize:ABBY_SELECT_SIZE];
	[_abbySelect setPosition:ABBY_SELECT_POSITION];
	[_abbySelect setZPosition:1];
	[self addChild:_abbySelect];
	
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	UITouch *touch = [touches anyObject];
	CGPoint point = [touch locationInNode:self.window];
	if ([_startGameButton containsPoint:point]) {
		[_sceneManager presentSceneWithID:GAME_SCENE_ID];
	} else if ([_billySelect containsPoint:point]) {
		[self billySelectPressed];
	} else if ([_steveSelect containsPoint:point]) {
		[self steveSelectPressed];
	} else if ([_abbySelect containsPoint:point]) {
		[self abbySelectPressed];
	}
}

- (void)billySelectPressed {
	[_selectBorder setPosition:BILLY_SELECT_POSITION];
	[_selectBorder setSize:BILLY_SELECT_SIZE];
	_brawlerSelection = BILLY_ID;
}

- (void)steveSelectPressed {
	[_selectBorder setPosition:STEVE_SELECT_POSITION];
	[_selectBorder setSize:STEVE_SELECT_SIZE];
	_brawlerSelection = STEVE_ID;
}

- (void)abbySelectPressed {
	[_selectBorder setPosition:ABBY_SELECT_POSITION];
	[_selectBorder setSize:ABBY_SELECT_SIZE];
	_brawlerSelection = ABBY_ID;
}

- (void)update:(CFTimeInterval)currentTime {

}

@end