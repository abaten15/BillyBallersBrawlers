//
//  ProfileLoader.m
//  Billy Baller's Brawlers
//
//  Created by Nick Abate on 4/25/19.
//  Copyright © 2019 Nick Abate. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "ProfileLoader.h"

@implementation ProfileLoader{

}

- (id) initWithManager:(SceneManager *)manager {

	self = [super init];
	
	_sceneManager = manager;
	
	NSString *tempPath = [SERVER_IP_ADDRESS stringByAppendingString:PROFILE_PHP_PATH];
	NSString *emptyQuery = [tempPath stringByAppendingString:@"?userid="];
	
	UIDevice *myDevice = [UIDevice currentDevice];
	NSString *deviceIdTemp = [[myDevice identifierForVendor] UUIDString];
	NSString *deviceId = [deviceIdTemp stringByReplacingOccurrencesOfString:@"-" withString:@""];
	
	NSString *query = [emptyQuery stringByAppendingString:deviceId];
	NSURL *myQuery = [NSURL URLWithString:query];
	
	NSURLSession *session = [NSURLSession sharedSession];
	NSURLSessionDataTask *task = [session dataTaskWithURL:myQuery completionHandler: ^(NSData *data, NSURLResponse *response, NSError *error) {
		if (data == nil) {
			NSLog(@"no data from server");
		}
		
		NSError *jsonError;
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:NSASCIIStringEncoding error:&jsonError];
		
        [self performSelectorOnMainThread:@selector(parseJSONData:) withObject:json waitUntilDone:NO];

	}];
	[task resume];
	return self;

}

- (void) parseJSONData:(NSDictionary *)json {
	NSString *status = [json valueForKey:@"status"];
	NSInteger num = [status integerValue];
	if (num == 1) {
		
	}
}

@end
