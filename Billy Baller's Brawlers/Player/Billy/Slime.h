//
//  Slime.h
//  Billy Baller's Brawlers
//
//  Created by Nick Abate on 4/9/19.
//  Copyright © 2019 Nick Abate. All rights reserved.
//

#ifndef Slime_h
#define Slime_h

#import <SpriteKit/SpriteKit.h>

#import "Player.h"
@class Player;

@interface Slime : SKSpriteNode

@property (nonatomic) BOOL isOpponents;
@property (nonatomic) BOOL slidePlayerRight;
@property (nonatomic) Player *playerToSlide;
+ (instancetype) slimeAt:(CGPoint)point isOpponents:(BOOL)isOpponentsIn;

@end

#endif /* Slime_h */
