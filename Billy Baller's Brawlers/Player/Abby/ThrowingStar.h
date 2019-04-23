//
//  ThrowingStar.h
//  Billy Baller's Brawlers
//
//  Created by Nick Abate on 4/15/19.
//  Copyright © 2019 Nick Abate. All rights reserved.
//

#ifndef ThrowingStar_h
#define ThrowingStar_h

#import <SpriteKit/SpriteKit.h>

#import "Direction.h"

#define THROWING_STAR_IMAGE_NAME @"ThrowingStar"
#define THROWING_STAR_SIZE CGSizeMake(20, 20)
#define THROWING_STAR_GOTO_OFFSET 500
#define THROWING_STAR_SPEED 1200
#define THROWING_STAR_DAMAGE 20

@interface ThrowingStar : SKSpriteNode

@property (nonatomic) BOOL isOpponents;
+ (instancetype) throwingStarAt:(CGPoint)point going:(Direction)dir isOpponents:(BOOL)isOpponentsIn;

- (void) splitStarPieces;

@end

#endif /* ThrowingStar_h */
