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

- (id) init {

	self = [super init];
	
	NSString *tempPath = [SERVER_IP_ADDRESS stringByAppendingString:PROFILE_PHP_PATH];
	NSString *query = [tempPath stringByAppendingString:@"?userid=60"];
	NSURL *myQuery = [NSURL URLWithString:query];
	
	NSURLSession *session = [NSURLSession sharedSession];
	NSURLSessionDataTask *task = [session dataTaskWithURL:myQuery completionHandler: ^(NSData *data, NSURLResponse *response, NSError *error) {
		if (data == nil) {
			NSLog(@"no daata");
		} else {
			NSLog(@"data");
		}
		/*
            NSMutableArray *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
 
            // print as json
            NSData *jsonData = [NSJSONSerialization dataWithJSONObject:json options:NSJSONWritingPrettyPrinted error:&error];
            NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
 
            NSLog(@"%@", jsonString);
            /*
            MessageTrack *track = [MessageTrackParser parseJson:json];
            callback(track, nil);
            */
	
	}];
	[task resume];
	
	/*
	NSString *tempPath = [SERVER_IP_ADDRESS stringByAppendingString:PROFILE_PHP_PATH];
	
	UIDevice *device = [UIDevice currentDevice];
	NSString *identifier = [[device identifierForVendor] UUIDString];
	
	NSString *queryStr = [@"?userid=" stringByAppendingString:identifier];
	
	_urlPath = [tempPath stringByAppendingString:queryStr];
	NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:5.0];
	[request setHTTPMethod:@"GET"];
	
    NSData *postData = [queryStr dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%d",(int)[postData length]];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setHTTPBody:postData];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
	
	NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    [[session dataTaskWithRequest:request completionHandler:completionHandler] resume];
	*/
	
	return self;

}

- (void) push:(NSString *)url keys:(NSDictionary *)keys file:(NSString *)file completionHandler:(void (^)(NSData *, NSURLResponse *, NSError *))completionHandler {

	NSString *tempPath = [SERVER_IP_ADDRESS stringByAppendingString:PROFILE_PHP_PATH];
	NSString *urlString = [tempPath stringByAppendingString:@"?userid=60"];
	NSURL *myUrl = [NSURL URLWithString:tempPath];
	NSLog(urlString);
	
	NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:myUrl cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:5.0];
	[request setHTTPMethod:@"GET"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
	
    NSString *contentType = @"userid=60";
    [request setValue:contentType forHTTPHeaderField: @"Content-Type"];
	
/*
	UIDevice *device = [UIDevice currentDevice];
	NSString *identifier = [[device identifierForVendor] UUIDString];
	NSString *queryStr = [@"?userid=" stringByAppendingString:@"1"];
	
    NSData *postData = [queryStr dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%d",(int)[postData length]];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setHTTPBody:postData];
	[request setValue:@"application/json;charset=UTF-8" forHTTPHeaderField:@"content-type"];
	
	NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithURL:myUrl completionHandler:completionHandler];
    [task resume];
*/

    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    [[session dataTaskWithRequest:request completionHandler:completionHandler] resume];
	
}

@end
