//
//  DroneArtilleryExplosion.h
//  Billy Baller's Brawlers
//
//  Created by Nick Abate on 5/12/19.
//  Copyright © 2019 Nick Abate. All rights reserved.
//

#ifndef DroneArtilleryExplosion_h
#define DroneArtilleryExplosion_h

#import <SpriteKit/SpriteKit.h>

#define DRONE_ARTILLERY_EXPLOSION_IMAGE_NAME @"Explosion"
#define DRONE_ARTILLERY_EXPLOSION_SIZE CGSizeMake(75,75)
#define DRONE_ARTILLERY_EXPLOSION_DURATION 0.3
#define DRONE_ARTILLERY_EXPLOSION_DAMAGE 10

@interface DroneArtilleryExplosion : SKSpriteNode

+ (instancetype) droneArtilleryExplosionAt:(CGPoint)point withZPosition:(int)zPosition;

@end

#endif /* DroneArtilleryExplosion_h */
