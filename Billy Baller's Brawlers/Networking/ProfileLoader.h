//
//  ProfileLoader.h
//  Billy Baller's Brawlers
//
//  Created by Nick Abate on 4/25/19.
//  Copyright © 2019 Nick Abate. All rights reserved.
//

#ifndef ProfileLoader_h
#define ProfileLoader_h

#define SERVER_IP_ADDRESS @"http://192.168.1.17"
#define PROFILE_PHP_PATH @"/~abaten15/billys/profile.php"

@interface ProfileLoader : NSObject

- (id) init;

@property (nonatomic) NSString *urlPath;

- (void) push:(NSString *)url keys:(NSDictionary *)keys file:(NSString *)file completionHandler:(void(^)(NSData *data, NSURLResponse *response, NSError *error))completionHandler;


@end

#endif /* ProfileLoader_h */
