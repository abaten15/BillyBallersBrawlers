//
//  GameViewController.h
//  Billy Baller's Brawlers
//
//  Created by Nick Abate on 2/6/19.
//  Copyright © 2019 Nick Abate. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SpriteKit/SpriteKit.h>
#import <GameplayKit/GameplayKit.h>

#import "SceneManager.h"

@interface GameViewController : UIViewController

@property (nonatomic) SceneManager *sceneManager;

@end
