//
//  DroneArtillery.h
//  Billy Baller's Brawlers
//
//  Created by Nick Abate on 5/12/19.
//  Copyright © 2019 Nick Abate. All rights reserved.
//

#ifndef DroneArtillery_h
#define DroneArtillery_h

#import <SpriteKit/SpriteKit.h>

#define DRONE_ARTILLERY_IMAGE_NAME @"DroneArtilleryBomb"
#define DRONE_ARTILLERY_SIZE CGSizeMake(40,24)
#define DRONE_ARTILLERY_FALL_OFFSET 60.0
#define DRONE_ARTILLERY_FALL_SPEED 400.0

@interface DroneArtillery : SKSpriteNode

@property (nonatomic) int zPositionForExplosion;
+ (instancetype) droneArtilleryAt:(CGPoint)point withZPosition:(int)zPositionIn;

- (void) explode;

@end

#endif /* DroneArtillery_h */
