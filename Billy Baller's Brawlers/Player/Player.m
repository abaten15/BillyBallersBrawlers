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
#import "ThrowingStar.h"
#import "StunBullet.h"
#import "Drone.h"

#import "Grenade.h"
#import "SlimeBall.h"
#import "SniperBullet.h"
#import "ShovelPath.h"
#import "ShovelWall.h"
#import "TommyTurret.h"

#import "HealthBar.h"
#import "CategoryDefinitions.h"

@implementation Player {

}

+ (instancetype)brawlerWithID:(int)brawlerIDIn isOpponent:(BOOL)isOpponentIn withServicer:(GameServicer *)gameServicer {

	Player *player;
	int maxHealth;
	CGSize playerSize = PLAYER_SIZE;
	CGFloat physicsBodySize = PLAYER_SIZE.width/2.0;
	switch (brawlerIDIn) {
	case BILLY_ID:
		player = [Player spriteNodeWithImageNamed:BILLY_IMAGE_NAME];
		player.speed = BILLY_SPEED;
		maxHealth = BILLY_MAX_HEALTH;
		player.mainShootingOffset = BILLY_MAIN_OFFSET;
		player.specialShootingOffset = BILLY_SPECIAL_OFFSET;
		player.mainCooldown = BILLY_MAIN_COOLDOWN;
		player.specialCooldown = BILLY_SPECIAL_COOLDOWN;
		playerSize = BILLY_PLAYER_SIZE;
		physicsBodySize = BILLY_PHYSICS_BODY_SIZE.width/2.0;
		break;
	case STEVE_ID:
		player = [Player spriteNodeWithImageNamed:STEVE_IMAGE_NAME];
		player.speed = STEVE_SPEED;
		maxHealth = STEVE_MAX_HEALTH;
		player.mainShootingOffset = STEVE_MAIN_OFFSET;
		player.specialShootingOffset = STEVE_SPECIAL_OFFSET;
		player.mainCooldown = STEVE_MAIN_COOLDOWN;
		player.specialCooldown = STEVE_SPECIAL_COOLDOWN;
		playerSize = STEVE_PLAYER_SIZE;
		physicsBodySize = STEVE_PHYSICS_BODY_SIZE.width/2.0;
		break;
	case ABBY_ID:
		player = [Player spriteNodeWithImageNamed:ABBY_IMAGE_NAME];
		player.speed = ABBY_SPEED;
		maxHealth = ABBY_MAX_HEALTH;
		player.mainShootingOffset = ABBY_MAIN_OFFSET;
		player.specialShootingOffset = ABBY_SPECIAL_OFFSET;
		player.mainCooldown = ABBY_MAIN_COOLDOWN;
		player.specialCooldown = ABBY_SPECIAL_COOLDOWN;
		playerSize = ABBY_PLAYER_SIZE;
		physicsBodySize = ABBY_PHYSICS_BODY_SIZE.width/2.0;
		break;
	case HARRY_ID:
		player = [Player spriteNodeWithImageNamed:HARRY_IMAGE_NAME];
		player.speed = HARRY_SPEED;
		maxHealth = HARRY_MAX_HEALTH;
		player.mainShootingOffset = HARRY_MAIN_OFFSET;
		player.specialShootingOffset = HARRY_SPECIAL_OFFSET;
		player.mainCooldown = HARRY_MAIN_COOLDOWN;
		player.specialCooldown = HARRY_SPECIAL_COOLDOWN;
		playerSize = HARRY_PLAYER_SIZE;
		physicsBodySize = HARRY_PHYSICS_BODY_SIZE.width/2.0;
		break;
	case TIM_ID:
		player = [Player spriteNodeWithImageNamed:TIM_IMAGE_NAME];
		player.speed = TIM_SPEED;
		maxHealth = TIM_MAX_HEALTH;
		player.mainShootingOffset = TIM_MAIN_OFFSET;
		player.specialShootingOffset = TIM_SPECIAL_OFFSET;
		player.mainCooldown = TIM_MAIN_COOLDOWN;
		player.specialCooldown = TIM_SPECIAL_COOLDOWN;
		playerSize = TIM_PLAYER_SIZE;
		physicsBodySize = TIM_PHYSICS_BODY_SIZE.width/2.0;
		break;
	default:
		player = [Player spriteNodeWithImageNamed:BILLY_IMAGE_NAME];
		player.speed = BILLY_SPEED;
		maxHealth = BILLY_MAX_HEALTH;
		player.mainShootingOffset = BILLY_MAIN_OFFSET;
		player.specialShootingOffset = BILLY_SPECIAL_OFFSET;
		player.mainCooldown = BILLY_MAIN_COOLDOWN;
		player.specialCooldown = BILLY_SPECIAL_COOLDOWN;
		break;
	}
	
	player.cooldownManager = [CooldownManager managerForBrawler:brawlerIDIn isOpponent:isOpponentIn];
	[player addChild:player.cooldownManager];
	
	[player setZPosition:2];
	
	player.gameServicer = gameServicer;
	player.brawlerID = brawlerIDIn;
	
	player.canShootMain = YES;
	player.canShootSpecial = YES;
	
	player.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:physicsBodySize];
	player.physicsBody.categoryBitMask = playerCategory;
	player.physicsBody.collisionBitMask = 0x0;
	player.physicsBody.contactTestBitMask = projectileCategory | aoeCategory | playerWallCategory; // May need changing later
	player.physicsBody.node.name = playerName;
	player.physicsBody.affectedByGravity = NO;
	player.physicsBody.dynamic = YES;
	player.name = playerName;
	
	[player setPosition:PLAYER_POSITION];
	[player setSize:playerSize];
	
	HealthBar *healthBar = [HealthBar healthBarWithMaxHealth:maxHealth withServicer:player.gameServicer];
	player.healthBar = healthBar;
	[player addChild:healthBar];
	
	player.isOpponent = isOpponentIn;
	
	if (player.isOpponent) {
		player.physicsBody.categoryBitMask = opponentCategory;
		player.name = opponentName;
		player.physicsBody.node.name = opponentName;
		player.mainShootingOffset = CGPointMake(player.mainShootingOffset.x, player.mainShootingOffset.y * -1);
		player.specialShootingOffset = CGPointMake(player.specialShootingOffset.x, player.specialShootingOffset.y * -1);
		player.yScale *= -1;
		player.position = CGPointMake(player.position.x, player.position.y * -1);
	}
	
	player.isSlidding = NO;
	player.isStunned = NO;
	player.isBouncing = NO;
	
	return player;
	
}

- (void) takeDamage:(int)damage {
	if ([_healthBar takeDamage:damage]) {
		NSLog(@"player is dead");
	}
}

- (void) moveTo:(CGFloat)newX {
	if (_isBouncing) {
		return;
	}
	if (_isSlidding) {
		int x = [self position].x;
		if (x > 0 && x != SLIDER_MAX_X) {
			CGFloat duration = ((CGFloat)abs((int)(SLIDER_MAX_X - self.position.x))) / self.speed;
			SKAction *motion = [SKAction moveTo:CGPointMake(SLIDER_MAX_X, self.position.y) duration:duration];
			[self runAction:motion];
		} else if (x < 0 && x != -1 * SLIDER_MAX_X) {
			CGFloat duration = ((CGFloat)abs((int)(-1 * SLIDER_MAX_X - self.position.x))) / self.speed;
			SKAction *motion = [SKAction moveTo:CGPointMake(-1 * SLIDER_MAX_X, self.position.y) duration:duration];
			[self runAction:motion];
		}
		return;
	}
	CGFloat duration = ((CGFloat)abs((int)(newX - self.position.x))) / self.speed;
	SKAction *motion = [SKAction moveTo:CGPointMake(newX, self.position.y) duration:duration];
	[self runAction:motion];
}


- (void) bounceTo:(CGFloat)newX takeDamage:(BOOL)shouldTakeDamage damageToTake:(int)damageToTake {
	if (_isBouncing) {
		return;
	}
	_isBouncing = YES;
	CGFloat duration = ((CGFloat)abs((int)(newX - self.position.x))) / self.speed;
	SKAction *motion = [SKAction moveTo:CGPointMake(newX, self.position.y) duration:duration];
	SKAction *endBounceAction = [SKAction performSelector:@selector(stopBouncing) onTarget:self];
	SKAction *sequence = [SKAction sequence:@[motion, endBounceAction]];
	[self runAction:sequence];
}

- (void) stopBouncing {
	_isBouncing = NO;
}

- (void) performMainAttack {
	if (!_isOpponent && !_canShootMain ) {
		return;
	}
	
	int flippedOffset = 0;
	CGPoint point;
	if (_flipped) {
		flippedOffset = _mainShootingOffset.x * -2;
	}
	
	point = CGPointMake(_mainShootingOffset.x + self.position.x + flippedOffset, _mainShootingOffset.y + self.position.y);
	Direction dir = North;
	if (_isOpponent) {
		dir = South;
	}
	
	if (self.brawlerID == BILLY_ID) {
		[self shootBulletAt:point going:dir];
	} else if (self.brawlerID == STEVE_ID) {
		[self shootBulletAt:point going:dir];
	} else if (self.brawlerID == ABBY_ID) {
		[self shootThrowingStarAt:point going:dir];
	} else if (self.brawlerID == HARRY_ID) {
		[self shootStunBulletAt:point going:dir];
	} else if (self.brawlerID == TIM_ID) {
		[self launchDroneAt:point];
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
	Bullet *bullet = [Bullet bulletAt:point going:dir isOpponents:_isOpponent];
	[[self parent] addChild:bullet];
}

- (void) shootThrowingStarAt:(CGPoint)point going:(Direction)dir {
	ThrowingStar *star = [ThrowingStar throwingStarAt:point going:dir isOpponents:_isOpponent];
	[[self parent] addChild:star];
}

- (void) shootStunBulletAt:(CGPoint)point going:(Direction)dir {
	StunBullet *stunbullet = [StunBullet stunBulletAt:point going:dir isOpponents:_isOpponent];
	[[self parent] addChild:stunbullet];
}

- (void) launchDroneAt:(CGPoint)point {
	Drone *drone = [Drone droneAt:point isOpponents:_isOpponent];
	[[self parent] addChild:drone];
}

- (void) performSpecialAttack {

	if (!_isOpponent && !_canShootSpecial) {
		return;
	}
	
	int flippedOffset = 0;
	if (_flipped) {
		flippedOffset = _specialShootingOffset.x * -2;
	}
	
	CGPoint point = CGPointMake(_specialShootingOffset.x + self.position.x + flippedOffset, _specialShootingOffset.y + self.position.y);
	
	if (_brawlerID == BILLY_ID) {
		[self shootGrenadeAt:point going:North];
	} else if (_brawlerID == STEVE_ID) {
		[self shootSlimeBallAt:point going:North];
	} else if (_brawlerID == ABBY_ID) {
		[self shootSniperBulletAt:point going:North];
	} else if (_brawlerID == HARRY_ID) {
		[self shootShovelWallAt:point going:North];
	} else if (_brawlerID == TIM_ID) {
		[self spawnTommyTurretAt:point];
	} else {
		[self shootGrenadeAt:point going:North];
	}
	 
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
		grenade = [Grenade grenadeAt:point going:North isOpponents:_isOpponent];
	} else {
		grenade = [Grenade grenadeAt:point going:South isOpponents:_isOpponent];
	}
	[[self parent] addChild:grenade];
}

- (void) shootSlimeBallAt:(CGPoint)point going:(Direction)dir {
	SlimeBall *slimeBall;
	if (_isOpponent) {
		slimeBall = [SlimeBall slimeBallAt:point going:North isOpponents:_isOpponent];
	} else {
		slimeBall = [SlimeBall slimeBallAt:point going:South isOpponents:_isOpponent];
	}
	slimeBall.gameScene = _gameScene;
	[[self parent] addChild:slimeBall];
}

- (void) shootSniperBulletAt:(CGPoint)point going:(Direction)dir {
	SniperBullet *sniperBullet;
	if (_isOpponent) {
		sniperBullet = [SniperBullet sniperBulletAt:point going:South isOpponents:_isOpponent];
	} else {
		sniperBullet = [SniperBullet sniperBulletAt:point going:North isOpponents:_isOpponent];
	}
	[[self parent] addChild:sniperBullet];
}

- (void) shootShovelWallAt:(CGPoint)point going:(Direction)dir {

	CGPoint spawnPoint = CGPointMake(point.x, point.y + SHOVEL_PATH_SIZE.height/2);
	ShovelPath *shovelPath = [ShovelPath shovelPathAt:spawnPoint isOpponents:_isOpponent];
	[self.parent addChild:shovelPath];

	/*
	ShovelWall *shovelWall;
	if (_isOpponent) {
		shovelWall = [ShovelWall shovelWallAt:point.x isOpponents:_isOpponent];
	} else {
		shovelWall = [ShovelWall shovelWallAt:point.x isOpponents:_isOpponent];
	}
	[[self parent] addChild:shovelWall];
	*/
	
}

- (void) spawnTommyTurretAt:(CGPoint)point {
	TommyTurret *turret = [TommyTurret turretAt:point isOpponents:_isOpponent];
	[turret shootBullet];
	[[self parent] addChild:turret];
}

- (void) updateShootingOffset {
	
}

- (void) flipBrawler {
	self.xScale *= -1;
	self.flipped = !self.flipped;
}

- (void) getStunned {
	self.isStunned = YES;
	
}

- (void) endStun {
	self.isStunned = NO;
}

@end
















