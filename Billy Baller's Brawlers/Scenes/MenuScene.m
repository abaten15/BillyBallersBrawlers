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
	
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	UITouch *touch = [touches anyObject];
	CGPoint point = [touch locationInNode:self.window];
	if ([_startGameButton containsPoint:point]) {
		[_sceneManager presentSceneWithID:GAME_SCENE_ID];
	}
}

- (void)update:(CFTimeInterval)currentTime {

}

@end
