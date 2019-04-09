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
#import "Grenade.h"

@implementation CooldownManager {

}

+ (instancetype) managerForBrawler:(int)brawlerID {

	CooldownManager *manager = [CooldownManager spriteNodeWithColor:[UIColor colorWithWhite:0 alpha:0] size:CGSizeMake(0, 0)];
	

	
	NSString *mainImageName = @"";
	NSString *specialImageName = @"";
	if (brawlerID == BILLY_ID) {
		mainImageName = BULLET_IMAGE_NAME;
		specialImageName = GRENADE_IMAGE_NAME;
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
	if (canShoot && !_canShootMainAttack) {
		_canShootMainAttack = YES;
		[self addChild:_mainNode];
	} else if (!canShoot && _canShootMainAttack) {
		_canShootMainAttack = NO;
		[_mainNode removeFromParent];
	}
}

- (void) setCanShootSpecial:(BOOL)canShoot {
	if (canShoot && !_canShootSpecialAttack) {
		_canShootSpecialAttack = YES;
		[self addChild:_specialNode];
	} else if (!canShoot && _canShootSpecialAttack) {
		_canShootSpecialAttack = NO;
		[_specialNode removeFromParent];
	}
}

@end
