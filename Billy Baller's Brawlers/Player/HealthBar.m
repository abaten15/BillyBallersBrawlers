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

+ (instancetype) healthBarWithMaxHealth:(CGFloat)maxHealth withServicer:(GameServicer *)servicer {
	
	HealthBar *healthBar = [HealthBar spriteNodeWithImageNamed:HEALTH_BAR_IMAGE_NAME];
	
	healthBar.gameServicer = servicer;
	
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
	CGFloat dw = (CGFloat)_currentHealth / (CGFloat)_maxHealth;
	width *= dw;
	NSLog(@"%f", dw);
	CGFloat height = HEALTH_BAR_SIZE.height;
	CGSize newSize = CGSizeMake(width, height);
	[self setSize:newSize];
	return retVal;
}

- (void) checkData:(NSData *)data {
	NSLog(@"checking data for health bar");
	NSString *dataStr = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
	NSString *healthPrefix;
	NSString *healthValue;
	@try {
		healthPrefix = [dataStr substringToIndex:HEALTH_UPDATE_PREFIX.length];
		healthValue = [dataStr substringFromIndex:HEALTH_UPDATE_PREFIX.length];
	}
	@catch (NSException *e) {
		return;
	}
	if ([healthPrefix isEqualToString:HEALTH_UPDATE_PREFIX]) {
		int newHealth = [healthValue intValue];
		[self takeDamage:_currentHealth - newHealth];
	}
}

@end




