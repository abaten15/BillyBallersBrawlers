//
//  HealthBar.m
//  Billy Baller's Brawlers
//
//  Created by Nick Abate on 3/27/19.
//  Copyright © 2019 Nick Abate. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SpriteKit/SpriteKit.h>

#import "HealthBar.h"

@implementation HealthBar

+ (instancetype) healthBarfor:(Player *)player withMaxHealth:(CGFloat)maxHealth {
	
	HealthBar *healthBar = [HealthBar spriteNodeWithImageNamed:HEALTH_BAR_IMAGE_NAME];
	
	[healthBar setPosition:HEALTH_BAR_OFFSET];
	[healthBar setSize:HEALTH_BAR_SIZE];
	
	return healthBar;
	
}

- (void) takeDamage {

}

@end
