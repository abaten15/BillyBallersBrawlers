//
//  Drone.h
//  Billy Baller's Brawlers
//
//  Created by Nick Abate on 5/10/19.
//  Copyright © 2019 Nick Abate. All rights reserved.
//

#ifndef Drone_h
#define Drone_h

#include <SpriteKit/SpriteKit.h>

#define DRONE_IMAGE_NAME_1 @"Drone1"
#define DRONE_IMAGE_NAME_2 @"Drone2"
#define DRONE_SIZE CGSizeMake(75,75)
#define DRONE_OFF_SCREEN_X -500
#define DRONE_SPEED 1500
#define DRONE_OPPONENTS_Y 500

@interface Drone : SKSpriteNode

@property (nonatomic) BOOL isOpponents;
+ (instancetype) droneAt:(CGPoint)point isOpponents:(BOOL)isOpponentsIn;

- (void)dropBomb;

@end

#endif /* Drone_h */
