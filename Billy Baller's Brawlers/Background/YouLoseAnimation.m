//
//  YouLoseAnimation.m
//  Billy Baller's Brawlers
//
//  Created by Nick Abate on 4/8/19.
//  Copyright © 2019 Nick Abate. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SpriteKit/SpriteKit.h>

#import "YouLoseAnimation.h"

@implementation YouLoseAnimation {

}

+ (instancetype) youLoseAnimation:(int)ID {
	
	YouLoseAnimation *retVal;
	
	if (retVal == YOU_LOSE_STATIC_ID) {
		retVal = [YouLoseAnimation spriteNodeWithImageNamed:YOU_LOSE_STATIC_IMAGE_NAME];
	}
	
	retVal.ID = ID;
	
	return retVal;
	
}

- (void) start {
	if (_ID == YOU_LOSE_STATIC_ID) {
		return;
	}
}

@end
