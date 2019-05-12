//
//  Animation.h
//  Billy Baller's Brawlers
//
//  Created by Nick Abate on 5/11/19.
//  Copyright © 2019 Nick Abate. All rights reserved.
//

#ifndef Animation_h
#define Animation_h

#import <SpriteKit/SpriteKit.h>

@interface Animation : SKSpriteNode

@property (nonatomic) SKSpriteNode *nodeToAnimate;
@property (nonatomic) NSMutableArray *imageNames;
+ (instancetype) animationFor:(SKSpriteNode *)nodeToAnimateIn withImages:(NSMutableArray *)imageNamesIn;

@end

#endif /* Animation_h */
