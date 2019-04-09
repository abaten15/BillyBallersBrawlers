//
//  YouLoseAnimation.h
//  Billy Baller's Brawlers
//
//  Created by Nick Abate on 4/8/19.
//  Copyright © 2019 Nick Abate. All rights reserved.
//

#ifndef YouLoseAnimation_h
#define YouLoseAnimation_h

#import <SpriteKit/SpriteKit.h>

#define YOU_LOSE_STATIC_ID 0
#define YOU_LOSE_STATIC_IMAGE_NAME @"YouLoseStatic"

@interface YouLoseAnimation : SKSpriteNode

@property (nonatomic) int ID;
+ (instancetype) youLoseAnimation:(int)ID;

- (void) start;

@end

#endif /* YouLoseAnimation_h */
