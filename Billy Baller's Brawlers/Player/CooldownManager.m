//
//  CooldownManager.m
//  Billy Baller's Brawlers
//
//  Created by Nick Abate on 4/8/19.
//  Copyright © 2019 Nick Abate. All rights reserved.
//

#import "CooldownManager.h"

#import <Foundation/Foundation.h>
#import <SpriteKit/SpriteKit.h>

#import "Player.h"
#import "Bullet.h"
#import "ThrowingStar.h"
#import "Grenade.h"
#import "SlimeBall.h"

@implementation CooldownManager {

}

+ (instancetype) managerForBrawler:(int)brawlerID isOpponent:(BOOL)isOpponentIn {

	CooldownManager *manager = [CooldownManager spriteNodeWithColor:[UIColor colorWithWhite:0 alpha:0] size:CGSizeMake(0, 0)];
	
	manager.isOpponent = isOpponentIn;
	
	NSString *mainImageName = @"";
	NSString *specialImageName = @"";
	if (brawlerID == BILLY_ID) {
		mainImageName = BULLET_IMAGE_NAME;
		specialImageName = GRENADE_IMAGE_NAME;
	} else if (brawlerID == STEVE_ID) {
		mainImageName = BULLET_IMAGE_NAME;
		specialImageName = SLIME_BALL_IMAGE_NAME;
	} else if (brawlerID == ABBY_ID) {
		mainImageName = THROWING_STAR_IMAGE_NAME;
	}
	
	manager.mainNode = [SKSpriteNode spriteNodeWithImageNamed:mainImageName];
	[manager.mainNode setSize:CM_NODE_SIZE];
	[manager.mainNode setPosition:CM_MAIN_NODE_OFFSET];
	[manager addChild:manager.mainNode];
	manager.specialNode = [SKSpriteNode spriteNodeWithImageNamed:specialImageName];
	[manager.specialNode setSize:CM_NODE_SIZE];
	[manager.specialNode setPosition:CM_SPECIAL_NODE_OFFSET];
	[manager addChild:manager.specialNode];
	
	manager.canShootMainAttack = YES;
	manager.canShootSpecialAttack = YES;
	
	return manager;
	
}

- (void) setCanShootMain:(BOOL)canShoot {
	if (_isOpponent) {
		_canShootMainAttack = YES;
		return;
	}
	if (canShoot && !_canShootMainAttack) {
		_canShootMainAttack = YES;
		[self addChild:_mainNode];
	} else if (!canShoot && _canShootMainAttack) {
		_canShootMainAttack = NO;
		[_mainNode removeFromParent];
	}
}

- (void) setCanShootSpecial:(BOOL)canShoot {
	if (_isOpponent) {
		_canShootSpecialAttack = YES;
		return;
	}
	if (canShoot && !_canShootSpecialAttack) {
		_canShootSpecialAttack = YES;
		[self addChild:_specialNode];
	} else if (!canShoot && _canShootSpecialAttack) {
		_canShootSpecialAttack = NO;
		[_specialNode removeFromParent];
	}
}

@end
