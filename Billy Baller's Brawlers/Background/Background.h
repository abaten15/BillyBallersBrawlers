//
//  Background.h
//  Billy Baller's Brawlers
//
//  Created by Nick Abate on 3/25/19.
//  Copyright © 2019 Nick Abate. All rights reserved.
//

#ifndef Background_h
#define Background_h

#import <SpriteKit/SpriteKit.h>

#import "Wall.h"
#import "GameScene.h"

#define BACKGROUND_VERTICAL_OFFSET 0 //80
#define BACKGROUND_POSITION CGPointMake(0,BACKGROUND_VERTICAL_OFFSET)
#define BACKGROUND_SIZE CGSizeMake(715, 1140)

@interface Background : SKSpriteNode

@property (nonatomic) Wall *wallTL;
@property (nonatomic) Wall *wallTR;
@property (nonatomic) Wall *wallBL;
@property (nonatomic) Wall *wallBR;

+ (instancetype)backgroundWithImageNamed:(NSString *)name addTo:(SKScene *)gameScene;

@end

#endif /* Background_h */
