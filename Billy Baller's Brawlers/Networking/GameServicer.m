//
//  GameServicer.m
//  Billy Baller's Brawlers
//
//  Created by Nick Abate on 4/2/19.
//  Copyright © 2019 Nick Abate. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MultipeerConnectivity/MultipeerConnectivity.h>
#import <SpriteKit/SpriteKit.h>

#import "GameServicer.h"

@implementation GameServicer {

}

- (id) init {

	self = [super init];
	
	_myPeerID = [[MCPeerID alloc] initWithDisplayName:[UIDevice currentDevice].name];
	
	_serviceAdvertiser = [[MCNearbyServiceAdvertiser alloc] initWithPeer:_myPeerID discoveryInfo:nil serviceType:GAME_SERVICE_TYPE];
	_serviceBrowser = [[MCNearbyServiceBrowser alloc] initWithPeer:_myPeerID serviceType:GAME_SERVICE_TYPE];
	
	self.serviceAdvertiser.delegate = self;
	self.serviceBrowser.delegate = self;
	
	return self;

}

- (void)advertiser:(nonnull MCNearbyServiceAdvertiser *)advertiser didReceiveInvitationFromPeer:(nonnull MCPeerID *)peerID withContext:(nullable NSData *)context invitationHandler:(nonnull void (^)(BOOL, MCSession * _Nullable))invitationHandler {
	invitationHandler(true, self.gameSession);
	NSLog(@"recieved invitataion");
	
}

- (void)browser:(nonnull MCNearbyServiceBrowser *)browser foundPeer:(nonnull MCPeerID *)peerID withDiscoveryInfo:(nullable NSDictionary<NSString *,NSString *> *)info {
	NSLog(@"found peer");
	_gameSession = [[MCSession alloc] initWithPeer:self.myPeerID];
	self.gameSession.delegate = self;
	[_serviceBrowser invitePeer:peerID toSession:_gameSession withContext:nil timeout:10];
}

- (void)browser:(nonnull MCNearbyServiceBrowser *)browser lostPeer:(nonnull MCPeerID *)peerID {
	NSLog(@"lost peer");
}

- (void) hostGame {
	[_serviceAdvertiser startAdvertisingPeer];
}

- (void) joinGame {
	[_serviceBrowser startBrowsingForPeers];
}

- (void) sendData:(NSString *)data {
	if (_gameSession.connectedPeers.count > 0) {
		[_gameSession sendData:[data dataUsingEncoding:kCFStringEncodingUTF8] toPeers:_gameSession.connectedPeers withMode:MCSessionSendDataReliable error:nil];
	}
}

- (void)session:(nonnull MCSession *)session didFinishReceivingResourceWithName:(nonnull NSString *)resourceName fromPeer:(nonnull MCPeerID *)peerID atURL:(nullable NSURL *)localURL withError:(nullable NSError *)error {
	
}

- (void)session:(nonnull MCSession *)session didReceiveData:(nonnull NSData *)data fromPeer:(nonnull MCPeerID *)peerID {
	NSLog(@"recieved data");
	NSString *string = [[NSString alloc] initWithData:data encoding:kCFStringEncodingUTF8];
	NSLog(string);
}

- (void)session:(nonnull MCSession *)session didReceiveStream:(nonnull NSInputStream *)stream withName:(nonnull NSString *)streamName fromPeer:(nonnull MCPeerID *)peerID {
	
}

- (void)session:(nonnull MCSession *)session didStartReceivingResourceWithName:(nonnull NSString *)resourceName fromPeer:(nonnull MCPeerID *)peerID withProgress:(nonnull NSProgress *)progress {
	
}

- (void)session:(nonnull MCSession *)session peer:(nonnull MCPeerID *)peerID didChangeState:(MCSessionState)state {
	
}

@end










