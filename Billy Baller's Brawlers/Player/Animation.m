//
//  Animation.m
//  Billy Baller's Brawlers
//
//  Created by Nick Abate on 5/11/19.
//  Copyright © 2019 Nick Abate. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SpriteKit/SpriteKit.h>

#import "Animation.h"

@implementation Animation {

}

+ (instancetype) animationFor:(SKSpriteNode *)nodeToAnimateIn withImages:(NSMutableArray *)imageNamesIn {

	Animation *animation = [Animation spriteNodeWithColor:[UIColor colorWithWhite:0.0 alpha:0.0] size:CGSizeMake(0, 0)];
	
	return animation;
	
}

@end
