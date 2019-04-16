//
//  CooldownManager.h
//  Billy Baller's Brawlers
//
//  Created by Nick Abate on 4/8/19.
//  Copyright © 2019 Nick Abate. All rights reserved.
//

#ifndef CooldownManager_h
#define CooldownManager_h

#import <SpriteKit/SpriteKit.h>

#define CM_NODE_SIZE CGSizeMake(20, 20)
#define CM_MAIN_NODE_OFFSET CGPointMake(70, 70)
#define CM_SPECIAL_NODE_OFFSET CGPointMake(70, 40)

@interface CooldownManager : SKSpriteNode

+ (instancetype) managerForBrawler:(int)brawlerID isOpponent:(BOOL)isOpponent;

@property (nonatomic) BOOL isOpponent;

@property (nonatomic) SKSpriteNode *mainNode;
@property (nonatomic) SKSpriteNode *specialNode;

@property (nonatomic) BOOL canShootMainAttack;
- (void) setCanShootMain:(BOOL)canShoot;
@property (nonatomic) BOOL canShootSpecialAttack;
- (void) setCanShootSpecial:(BOOL)canShoot;

@end

#endif /* CooldownManager_h */
