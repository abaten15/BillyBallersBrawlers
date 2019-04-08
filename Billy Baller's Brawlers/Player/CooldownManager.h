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

@interface CooldownManager : SKNode

+ (instancetype) managerForBrawler:(int)brawlerID;

@end

#endif /* CooldownManager_h */
