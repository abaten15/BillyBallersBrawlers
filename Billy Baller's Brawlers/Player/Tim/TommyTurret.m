//
//  TommyTurret.m
//  Billy Baller's Brawlers
//
//  Created by Nick Abate on 5/12/19.
//  Copyright © 2019 Nick Abate. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SpriteKit/SpriteKit.h>

#import "TommyTurret.h"

#import "Bullet.h"

@implementation TommyTurret {

}

+ (instancetype) turretAt:(CGPoint)point isOpponents:(BOOL)isOpponentsIn {

	TommyTurret *turret = [TommyTurret spriteNodeWithImageNamed:TOMMY_TURRET_IMAGE_NAME];
	
	turret.isOpponents = isOpponentsIn;
	
	if (turret.isOpponents) {
		[turret setYScale:-1];
	}
	
	[turret setPosition:point];
	[turret setSize:TOMMY_TURRET_SIZE];
	
	turret.shotCount = 0;
	
	return turret;
	
}

- (void) shootBullet {
	
	CGPoint spawnLocation = CGPointMake(self.position.x + TOMMY_TURRET_SHOOTING_OFFSET.x, self.position.y + TOMMY_TURRET_SHOOTING_OFFSET.y);
	Direction bulletDirection = North;
	if (_isOpponents) {
		bulletDirection = South;
	}
	
	Bullet *bullet = [Bullet bulletAt:spawnLocation going:bulletDirection isOpponents:_isOpponents];
	[self.parent addChild:bullet];
	
	self.shotCount += 1;
	if (_shotCount >= 6) {
		[self removeFromParent];
	} else {
		SKAction *waitAction = [SKAction waitForDuration:TOMMY_TURRET_SHOOTING_COOLDOWN];
		SKAction *shootingAction = [SKAction performSelector:@selector(shootBullet) onTarget:self];
		SKAction *sequence = [SKAction sequence:@[waitAction, shootingAction]];
		[self runAction:sequence];
	}
	
}

@end
