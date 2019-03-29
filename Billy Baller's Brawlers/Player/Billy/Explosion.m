//
//  Explosion.m
//  Billy Baller's Brawlers
//
//  Created by Nick Abate on 3/27/19.
//  Copyright © 2019 Nick Abate. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SpriteKit/SpriteKit.h>

#import "Explosion.h"

@implementation Explosion

+ (instancetype) explosionAt:(CGPoint)point withDuration:(CGFloat)duration {

	Explosion *explosion = [Explosion spriteNodeWithImageNamed:EXPLOSION_IMAGE_NAME];
	
	[explosion setPosition:point];
	[explosion setSize:EXPLOSION_SIZE];
	
	SKAction *delay = [SKAction waitForDuration:duration];
	SKAction *destroyAction = [SKAction performSelector:@selector(removeFromParent) withObject:self];
	SKAction *finalAction = [SKAction sequence:@[delay, destroyAction]];
	[explosion runAction:finalAction];
	
	return explosion;

}

@end
