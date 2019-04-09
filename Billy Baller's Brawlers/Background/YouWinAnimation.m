//
//  YouWinAnimation.m
//  Billy Baller's Brawlers
//
//  Created by Nick Abate on 4/8/19.
//  Copyright © 2019 Nick Abate. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SpriteKit/SpriteKit.h>

#import "YouWinAnimation.h"

@implementation YouWinAnimation {

}

+ (instancetype) youWinAnimation:(int)ID {

	YouWinAnimation *youWinAnimation;
	
	if (ID == YOU_WIN_STATIC_ID) {
		youWinAnimation = [YouWinAnimation spriteNodeWithImageNamed:YOU_WIN_STATIC_IMAGE_NAME];
	}
	
	youWinAnimation.ID = ID;
	
	return youWinAnimation;

}

- (void) start {
	if (_ID == YOU_WIN_STATIC_ID) {
		return;
	}
}

@end
