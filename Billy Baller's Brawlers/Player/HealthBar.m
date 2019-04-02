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

+ (instancetype) healthBarWithMaxHealth:(CGFloat)maxHealth {
	
	HealthBar *healthBar = [HealthBar spriteNodeWithImageNamed:HEALTH_BAR_IMAGE_NAME];
	
	[healthBar setPosition:HEALTH_BAR_OFFSET];
	[healthBar setSize:HEALTH_BAR_SIZE];
	
	healthBar.maxHealth = maxHealth;
	healthBar.currentHealth = maxHealth;;
	
	return healthBar;
	
}

- (BOOL) takeDamage:(int) damage {
	_currentHealth -= damage;
	BOOL retVal = NO;
	if (_currentHealth <= 0) {
		_currentHealth = 0;
		retVal = YES;
	}
	CGFloat width = HEALTH_BAR_SIZE.width;
	width *= (_currentHealth / _maxHealth);
	CGFloat height = HEALTH_BAR_SIZE.height;
	CGSize newSize = CGSizeMake(width, height);
	[self setSize:newSize];
	return retVal;
}

@end
