//
//  Player.m
//  Billy Baller's Brawlers
//
//  Created by Nick Abate on 3/25/19.
//  Copyright © 2019 Nick Abate. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SpriteKit/SpriteKit.h>

#import "Player.h"
#import "Bullet.h"
#import "Grenade.h"
#import "HealthBar.h"

@implementation Player {

}

+ (instancetype)brawlerWithID:(int) brawlerID {

	Player *player;
	int maxHealth;
	switch (brawlerID) {
	case BILLY_ID:
		player = [Player spriteNodeWithImageNamed:BILLY_IMAGE_NAME];
		player.speed = BILLY_SPEED;
		maxHealth = BILLY_MAX_HEALTH;
		break;
	case STEVE_ID:
		player = [Player spriteNodeWithImageNamed:STEVE_IMAGE_NAME];
		player.speed = STEVE_SPEED;
		maxHealth = STEVE_MAX_HEALTH;
		break;
	default:
		player = [Player spriteNodeWithImageNamed:BILLY_IMAGE_NAME];
		player.speed = BILLY_SPEED;
		maxHealth = BILLY_MAX_HEALTH;
		break;
	}
	
	[player setPosition:PLAYER_POSITION];
	[player setSize:PLAYER_SIZE];
	
	HealthBar *healthBar = [HealthBar healthBarWithMaxHealth:maxHealth];
	player.healthBar = healthBar;
	[player addChild:healthBar];
	
	return player;
	
}

- (void) takeDamage:(int)damage {
	if ([_healthBar takeDamage:damage]) {
		NSLog(@"player is dead");
	}
}

- (void) moveTo:(CGFloat)newX {
	CGFloat duration = ((CGFloat)abs((int)(newX - self.position.x))) / self.speed;
	SKAction *motion = [SKAction moveTo:CGPointMake(newX, self.position.y) duration:duration];
	[self runAction:motion];
}

- (void) performMainAttack {
	int flippedOffset = 0;
	CGPoint point;
	if (self.brawlerID == BILLY_ID) {
		if (_flipped) {
			flippedOffset = BILLY_MAIN_OFFSET.x * -2;
		}
		point = CGPointMake(BILLY_MAIN_OFFSET.x + self.position.x + flippedOffset, BILLY_MAIN_OFFSET.y + self.position.y);
		Bullet *bullet = [Bullet bulletAt:point going:North];
		[[self parent] addChild:bullet];
	} else {
		if (_flipped) {
			flippedOffset = BILLY_MAIN_OFFSET.x * -2;
		}
		point = CGPointMake(BILLY_MAIN_OFFSET.x + self.position.x + flippedOffset, BILLY_MAIN_OFFSET.y + self.position.y);
		Bullet *bulletDefault = [Bullet bulletAt:point going:North];
		[[self parent] addChild:bulletDefault];
	}
}

- (void) performSpecialAttack {
	int flippedOffset = 0;
	if (_flipped) {
		flippedOffset = BILLY_MAIN_OFFSET.x * -2;
	}
	CGPoint point = CGPointMake(BILLY_MAIN_OFFSET.x + self.position.x + flippedOffset, BILLY_MAIN_OFFSET.y + self.position.y);
	Grenade *grenade = [Grenade grenadeAt:point going:North];
	[[self parent] addChild:grenade];
}

- (void) flipBrawler {
	self.xScale *= -1;
	self.flipped = !self.flipped;
}

@end
















