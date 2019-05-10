//
//  StunBullet.h
//  Billy Baller's Brawlers
//
//  Created by Nick Abate on 4/28/19.
//  Copyright © 2019 Nick Abate. All rights reserved.
//

#ifndef StunBullet_h
#define StunBullet_h

#import <SpriteKit/SpriteKit.h>

#import "Direction.h"

#define STUN_BULLET_IMAGE_NAME @"StunBullet"
#define STUN_BULLET_SIZE CGSizeMake(50, 50)
#define STUN_BULLET_SPEED 1200
#define STUN_BULLET_GOTO_OFFSET 900
#define STUN_BULLET_DAMAGE 25
#define STUN_BULLET_STUN_DURATION 1.0

@interface StunBullet : SKSpriteNode

@property (nonatomic) BOOL isOpponents;
+ (instancetype) stunBulletAt:(CGPoint)point going:(Direction)direction isOpponents:(BOOL)isOpponentsIn;

@end

#endif /* StunBullet_h */
