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
#import "CategoryDefinitions.h"

@implementation Player {

}

+ (instancetype)brawlerWithID:(int)brawlerID isOpponent:(BOOL)isOpponentIn withServicer:(GameServicer *)gameServicer {

	Player *player;
	player.gameServicer = gameServicer;
	int maxHealth;
	switch (brawlerID) {
	case BILLY_ID:
		player = [Player spriteNodeWithImageNamed:BILLY_IMAGE_NAME];
		player.speed = BILLY_SPEED;
		maxHealth = BILLY_MAX_HEALTH;
		player.shootingOffset = BILLY_MAIN_OFFSET;
		player.mainCooldown = BILLY_MAIN_COOLDOWN;
		player.specialCooldown = BILLY_SPECIAL_COOLDOWN;
		break;
	case STEVE_ID:
		player = [Player spriteNodeWithImageNamed:STEVE_IMAGE_NAME];
		player.speed = STEVE_SPEED;
		maxHealth = STEVE_MAX_HEALTH;
		player.shootingOffset = BILLY_MAIN_OFFSET;
		break;
	default:
		player = [Player spriteNodeWithImageNamed:BILLY_IMAGE_NAME];
		player.speed = BILLY_SPEED;
		maxHealth = BILLY_MAX_HEALTH;
		player.shootingOffset = BILLY_MAIN_OFFSET;
		break;
	}
	if (!isOpponentIn) {
		player.cooldownManager = [CooldownManager managerForBrawler:brawlerID];
		[player addChild:player.cooldownManager];
	}
	
	player.canShootMain = YES;
	player.canShootSpecial = YES;
	
	player.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:PLAYER_SIZE.width/2];
	player.physicsBody.categoryBitMask = playerCategory;
	player.physicsBody.collisionBitMask = 0x0;
	player.physicsBody.contactTestBitMask = bulletCategory | grenadeCategory; // May need changing later
	player.physicsBody.node.name = playerName;
	player.physicsBody.affectedByGravity = NO;
	player.physicsBody.dynamic = YES;
	player.name = playerName;
	
	[player setPosition:PLAYER_POSITION];
	[player setSize:PLAYER_SIZE];
	
	HealthBar *healthBar = [HealthBar healthBarWithMaxHealth:maxHealth withServicer:player.gameServicer];
	player.healthBar = healthBar;
	[player addChild:healthBar];
	
	player.isOpponent = isOpponentIn;
	
	if (player.isOpponent) {
		player.physicsBody.categoryBitMask = opponentCategory;
		player.name = opponentName;
		player.physicsBody.node.name = opponentName;
		player.shootingOffset = CGPointMake(player.shootingOffset.x, player.shootingOffset.y * -1);
		player.yScale *= -1;
		player.position = CGPointMake(player.position.x, player.position.y * -1);
	}
	
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
	if (!_isOpponent && !_canShootMain ) {
		return;
	}
	int flippedOffset = 0;
	CGPoint point;
	if (_flipped) {
		flippedOffset = _shootingOffset.x * -2;
	}
	point = CGPointMake(BILLY_MAIN_OFFSET.x + self.position.x + flippedOffset, _shootingOffset.y + self.position.y);
	Direction dir = North;
	if (_isOpponent) {
		dir = South;
	}
	if (self.brawlerID == BILLY_ID) {
		[self shootBulletAt:point going:dir];
	} else {
		[self shootBulletAt:point going:dir];
	}
	_canShootMain = NO;
	[_cooldownManager setCanShootMain:_canShootMain];
	[self performSelector:@selector(endMainCooldown) withObject:nil afterDelay:_mainCooldown];
}

- (void) endMainCooldown {
	_canShootMain = YES;
	[_cooldownManager setCanShootMain:_canShootMain];
}

- (void) shootBulletAt:(CGPoint)point going:(Direction)dir {
	Bullet *bullet;
	if (_isOpponent) {
		bullet.name = [bulletName stringByAppendingString:OPPONENT_POSTFIX];
		bullet = [Bullet bulletAt:point going:dir isOpponents:_isOpponent];
	} else {
		bullet = [Bullet bulletAt:point going:dir isOpponents:_isOpponent];
	}
	[[self parent] addChild:bullet];
}

- (void) performSpecialAttack {
	if (!_isOpponent && !_canShootSpecial) {
		return;
	}
	int flippedOffset = 0;
	if (_flipped) {
		flippedOffset = _shootingOffset.x * -2;
	}
	CGPoint point = CGPointMake(_shootingOffset.x + self.position.x + flippedOffset, _shootingOffset.y + self.position.y);
	[self shootGrenadeAt:point going:North];
	_canShootSpecial = NO;
	[_cooldownManager setCanShootSpecial:_canShootSpecial];
	[self performSelector:@selector(endSpecialCooldown) withObject:nil afterDelay:_specialCooldown];
}

- (void) endSpecialCooldown {
	_canShootSpecial = YES;
	[_cooldownManager setCanShootSpecial:_canShootSpecial];
}

- (void) shootGrenadeAt:(CGPoint)point going:(Direction)dir {
	Grenade *grenade;
	if (_isOpponent) {
		grenade.name = [grenadeName stringByAppendingString:OPPONENT_POSTFIX];
		grenade = [Grenade grenadeAt:point going:North isOpponents:_isOpponent];
	} else {
		grenade = [Grenade grenadeAt:point going:South isOpponents:_isOpponent];
	}
	[[self parent] addChild:grenade];
}

- (void) updateShootingOffset {
	
}

- (void) flipBrawler {
	self.xScale *= -1;
	self.flipped = !self.flipped;
}

@end
















