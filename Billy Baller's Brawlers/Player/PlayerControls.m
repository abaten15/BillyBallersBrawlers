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

+ (instancetype)controlsForPlayer:(Player *)playerIn withServicer:(GameServicer *)gameServicerIn {

	PlayerControls *controls = [PlayerControls node];
	
	controls.playerToControl = playerIn;
	
	controls.gameServicer = gameServicerIn;
	
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
		[self mainAttackButtonPressed:point sendData:YES];
	}
	else if ([_specialAttackButton containsPoint:point]) {
		[self specialAttackButtonPressed:point sendData:YES];
	}
	else if ([_flipBrawlerButton containsPoint:point]) {
		[self flipBrawlerButtonPressed:point sendData:YES];
	}
	else if ([_slider containsPoint:point]) {
		[self sliderMotion:point.x sendData:YES];
	}

}

- (void) checkControlsMoved:(CGPoint)point {

	if ([_slider containsPoint:point]) {
		[self sliderMotion:point.x sendData:YES];
	}

}

- (void) checkControlsUp:(CGPoint)point {

}

- (void) sliderMotion:(CGFloat)newX sendData:(BOOL)shouldSendData {
	if (newX > SLIDER_MAX_X) {
		newX = SLIDER_MAX_X;
	} else if (newX < -SLIDER_MAX_X) {
		newX = -SLIDER_MAX_X;
	}
	[_playerToControl moveTo:newX];
	
	// Sending data
	if (shouldSendData) {
		NSString *stringData = [SLIDER_NETWORK_PREFIX stringByAppendingString:[[NSNumber numberWithInt:(int)newX] stringValue]];
		[_gameServicer sendData:stringData];
	}
}

- (void) mainAttackButtonPressed:(CGPoint)point sendData:(BOOL)shouldSendData {
	[_playerToControl performMainAttack];
	if (shouldSendData) {
		NSString *stringData = MAIN_BUTTON_NETWORK_PREFIX;
		[_gameServicer sendData:stringData];
	}
}

- (void) specialAttackButtonPressed:(CGPoint)point sendData:(BOOL)shouldSendData {
	[_playerToControl performSpecialAttack];
	if (shouldSendData) {
		NSString *stringData = SPECIAL_BUTTON_NETWORK_PREFIX;
		[_gameServicer sendData:stringData];
	}
}

- (void) flipBrawlerButtonPressed:(CGPoint)point sendData:(BOOL)shouldSendData {
	[_playerToControl flipBrawler];
	if (shouldSendData) {
		NSString *stringData = FLIP_BUTTON_NETWORK_PREFIX;
		[_gameServicer sendData:stringData];
	}
}

- (void) performActionFromData:(NSData *)data {
	NSString *string = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
	CGPoint point = CGPointMake(0, 0);
	if ([string isEqualToString:FLIP_BUTTON_NETWORK_PREFIX]) {
		[self flipBrawlerButtonPressed:point sendData:NO];
		return;
	} else if ([string isEqualToString:MAIN_BUTTON_NETWORK_PREFIX]) {
		[self mainAttackButtonPressed:point sendData:NO];
		return;
	} else if ([string isEqualToString:SPECIAL_BUTTON_NETWORK_PREFIX]) {
		[self specialAttackButtonPressed:point sendData:NO];
		return;
	}
	
	NSString *prefix;
	NSString *newX;
	@try {
		prefix = [string substringToIndex:SLIDER_NETWORK_PREFIX.length];
		newX = [string substringFromIndex:SLIDER_NETWORK_PREFIX.length];
	}
	@catch (NSException *e) {
	
	}
	@finally {
	
	}
	
	if ([prefix isEqualToString:SLIDER_NETWORK_PREFIX]) {
		CGFloat newXFloat = [newX intValue];
		[self sliderMotion:newXFloat sendData:NO];
	}
}

@end




















