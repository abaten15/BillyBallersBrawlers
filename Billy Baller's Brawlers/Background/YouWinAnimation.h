//
//  YouWinAnimation.h
//  Billy Baller's Brawlers
//
//  Created by Nick Abate on 4/8/19.
//  Copyright © 2019 Nick Abate. All rights reserved.
//

#ifndef YouWinAnimation_h
#define YouWinAnimation_h

#import <SpriteKit/SpriteKit.h>

#define YOU_WIN_STATIC_ID 0
#define YOU_WIN_STATIC_IMAGE_NAME @"YouWinStatic"

@interface YouWinAnimation : SKSpriteNode

@property (nonatomic) int ID;
+ (instancetype) youWinAnimation:(int)ID;

- (void) start;

@end

#endif /* YouWinAnimation_h */
