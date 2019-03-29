//
//  PlayerControls.m
//  Billy Baller's Brawlers
//
//  Created by Nick Abate on 3/25/19.
//  Copyright © 2019 Nick Abate. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SpriteKit/SpriteKit.h>

#import "PlayerControls.h"

@implementation PlayerControls {

}

+ (instancetype)controlsForPlayer:(Player *)playerIn {

	PlayerControls *controls = [PlayerControls node];
	
	controls.playerToControl = playerIn;
	
	controls.slider = [SKSpriteNode spriteNodeWithColor:[UIColor colorWithWhite:1 alpha:0] size:SLIDER_SIZE];
	[controls.slider setPosition:SLIDER_POSITION];
	[controls addChild:controls.slider];
	
	controls.mainAttackButton = [SKSpriteNode spriteNodeWithImageNamed:@"MainButton"];
	[controls.mainAttackButton setPosition:MAIN_BUTTON_POSITION];
	[controls.mainAttackButton setSize:MAIN_BUTTON_SIZE];
	[controls addChild:controls.mainAttackButton];
	
	controls.specialAttackButton = [SKSpriteNode spriteNodeWithImageNamed:@"SpecialButton"];
	[controls.specialAttackButton setPosition:SPECIAL_BUTTON_POSITION];
	[controls.specialAttackButton setSize:SPECIAL_BUTTON_SIZE];
	[controls addChild:controls.specialAttackButton];
	
	controls.flipBrawlerButton = [SKSpriteNode spriteNodeWithImageNamed:@"FlipButton"];
	[controls.flipBrawlerButton setPosition:FLIP_BUTTON_POSITION];
	[controls.flipBrawlerButton setSize:FLIP_BUTTON_SIZE];
	[controls addChild:controls.flipBrawlerButton];
	
	return controls;
	
}

- (void) checkControlsDown:(CGPoint)point {

	if ([_mainAttackButton containsPoint:point]) {
		[self mainAttackButtonPressed:point];
	}
	else if ([_specialAttackButton containsPoint:point]) {
		[self specialAttackButtonPressed:point];
	}
	else if ([_flipBrawlerButton containsPoint:point]) {
		[self flipBrawlerButtonPressed:point];
	}
	else if ([_slider containsPoint:point]) {
		[self sliderMotion:point.x];
	}

}

- (void) checkControlsMoved:(CGPoint)point {

	if ([_slider containsPoint:point]) {
		[self sliderMotion:point.x];
	}

}

- (void) checkControlsUp:(CGPoint)point {

}

- (void) sliderMotion:(CGFloat)newX {
	if (newX > SLIDER_MAX_X) {
		newX = SLIDER_MAX_X;
	} else if (newX < -SLIDER_MAX_X) {
		newX = -SLIDER_MAX_X;
	}
	[_playerToControl moveTo:newX];
}

- (void) mainAttackButtonPressed:(CGPoint)point {
	[_playerToControl performMainAttack];
}

- (void) specialAttackButtonPressed:(CGPoint)point {
	[_playerToControl performSpecialAttack];
}

- (void) flipBrawlerButtonPressed:(CGPoint)point {
	[_playerToControl flipBrawler];
}

@end




















