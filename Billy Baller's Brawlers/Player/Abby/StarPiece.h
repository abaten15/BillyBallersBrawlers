//
//  StarPiece.h
//  Billy Baller's Brawlers
//
//  Created by Nick Abate on 4/15/19.
//  Copyright © 2019 Nick Abate. All rights reserved.
//

#ifndef StarPiece_h
#define StarPiece_h

#import <SpriteKit/SpriteKit.h>

#import "Direction.h"

#define STAR_PIECE_IMAGE_NAME @"StarPiece"
#define STAR_PIECE_SIZE CGSizeMake(20, 20)
#define STAR_PIECE_GOTO_OFFSET 500
#define STAR_PIECE_SPEED 1000

@interface StarPiece : SKSpriteNode

@property (nonatomic) BOOL isOpponents;
+ (instancetype) starPieceAt:(CGPoint)point going:(Direction)dir isOpponents:(BOOL)isOpponentsIn;

@end

#endif /* StarPiece_h */
