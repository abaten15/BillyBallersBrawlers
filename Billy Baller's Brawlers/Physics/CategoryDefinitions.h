//
//  CategoryDefinitions.h
//  Billy Baller's Brawlers
//
//  Created by Nick Abate on 3/29/19.
//  Copyright © 2019 Nick Abate. All rights reserved.
//

#ifndef CategoryDefinitions_h
#define CategoryDefinitions_h

#import <SpriteKit/SpriteKit.h>

static const u_int32_t playerCategory = 0x1 << 0;
static const u_int32_t opponentCategory = 0x1 << 5;
static const u_int32_t wallCategory = 0x1 << 1;
static const u_int32_t bulletCategory = 0x1 << 2;
static const u_int32_t grenadeCategory = 0x1 << 3;
static const u_int32_t explosionCategory = 0x1 << 4;

#define playerName @"playerName"
#define opponentName @"opponentCategory"
#define wallName @"wallName"
#define bulletName @"bulletName"
#define grenadeName @"grenadeName"
#define explosionName @"explosionName"

static id<SKPhysicsContactDelegate> SceneContactDelegate;

#endif /* CategoryDefinitions_h */
