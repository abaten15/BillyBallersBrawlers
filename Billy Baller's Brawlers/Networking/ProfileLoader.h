//
//  ProfileLoader.h
//  Billy Baller's Brawlers
//
//  Created by Nick Abate on 4/25/19.
//  Copyright © 2019 Nick Abate. All rights reserved.
//

#ifndef ProfileLoader_h
#define ProfileLoader_h

#define SERVER_IP_ADDRESS @"http://149.125.51.67"
#define PROFILE_PHP_PATH @"/~abaten15/billys/profile.php"

#import "SceneManager.h"
@class SceneManager;

@interface ProfileLoader : NSObject

@property (nonatomic) NSString *urlPath;
@property (nonatomic) SceneManager *sceneManager;

- (id) initWithManager:(SceneManager *)manager;

- (void) parseJSONData:(NSDictionary *)json;

@end

#endif /* ProfileLoader_h */
