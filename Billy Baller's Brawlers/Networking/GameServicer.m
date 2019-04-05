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

#import "HealthBar.h"

static NSString * const GameServiceType = @"game-service";

@implementation GameServicer {

}

- (id) initWithScene:(GameScene *)gameSceneIn {

	self = [super init];
	
	_gameScene = gameSceneIn;
	
	_myPeerID = [[MCPeerID alloc] initWithDisplayName:[UIDevice currentDevice].name];
	
	_gameSession = [[MCSession alloc] initWithPeer:self.myPeerID securityIdentity:nil encryptionPreference:MCEncryptionNone];
	self.gameSession.delegate = self;
	
	_advertiserAssistant = [[MCAdvertiserAssistant alloc] initWithServiceType:GameServiceType discoveryInfo:nil session:_gameSession];
	
	_serviceBrowser = [[MCNearbyServiceBrowser alloc] initWithPeer:_myPeerID serviceType:GameServiceType];
	self.serviceBrowser.delegate = self;
	
	_sessionConnected = NO;
	
	return self;

}

- (MCSession *) gameSession {
	if (!_gameSession) {
		_gameSession = [[MCSession alloc] initWithPeer:self.myPeerID securityIdentity:nil encryptionPreference:MCEncryptionNone];
		self.gameSession.delegate = self;
	}
	return _gameSession;
}


- (void)advertiser:(nonnull MCNearbyServiceAdvertiser *)advertiser didReceiveInvitationFromPeer:(nonnull MCPeerID *)peerID withContext:(nullable NSData *)context invitationHandler:(nonnull void (^)(BOOL, MCSession * _Nullable))invitationHandler {
	self.gameSession = [[MCSession alloc] initWithPeer:self.myPeerID securityIdentity:nil encryptionPreference:MCEncryptionNone];
	self.gameSession.delegate = self;
	invitationHandler(YES, self.gameSession);
	NSLog(@"recieved invitataion");
	
}

- (void)browser:(nonnull MCNearbyServiceBrowser *)browser foundPeer:(nonnull MCPeerID *)peerID withDiscoveryInfo:(nullable NSDictionary<NSString *,NSString *> *)info {
	NSLog(@"found peer");
	self.gameSession = [[MCSession alloc] initWithPeer:self.myPeerID securityIdentity:nil encryptionPreference:MCEncryptionNone];
	self.gameSession.delegate = self;
	[_serviceBrowser invitePeer:peerID toSession:self.gameSession withContext:nil timeout:10];
	_sessionConnected = YES;
}

- (void)browser:(nonnull MCNearbyServiceBrowser *)browser lostPeer:(nonnull MCPeerID *)peerID {
	NSLog(@"lost peer");
}

- (void) hostGame {
	[_advertiserAssistant start];
}

- (void) joinGame {
	[_serviceBrowser startBrowsingForPeers];
}

- (void) sendData:(NSString *)data {
	if (self.sessionConnected == YES && self.gameSession.connectedPeers.count > 0) {
		NSData *dataToSend = [data dataUsingEncoding:kCFStringEncodingUTF8];
		[self.gameSession sendData:dataToSend toPeers:self.gameSession.connectedPeers withMode:MCSessionSendDataReliable error:nil];
	}
}

- (void)session:(nonnull MCSession *)session didFinishReceivingResourceWithName:(nonnull NSString *)resourceName fromPeer:(nonnull MCPeerID *)peerID atURL:(nullable NSURL *)localURL withError:(nullable NSError *)error {
	
}

- (void)session:(nonnull MCSession *)session didReceiveData:(nonnull NSData *)data fromPeer:(nonnull MCPeerID *)peerID {
	[_gameScene checkOpponentData:data];
}

- (void)session:(nonnull MCSession *)session didReceiveStream:(nonnull NSInputStream *)stream withName:(nonnull NSString *)streamName fromPeer:(nonnull MCPeerID *)peerID {
	
}

- (void)session:(nonnull MCSession *)session didStartReceivingResourceWithName:(nonnull NSString *)resourceName fromPeer:(nonnull MCPeerID *)peerID withProgress:(nonnull NSProgress *)progress {
	
}

- (void)session:(nonnull MCSession *)session peer:(nonnull MCPeerID *)peerID didChangeState:(MCSessionState)state {
	if (state == MCSessionStateConnecting) {
		NSLog(@"connecting state");
	} else if (state == MCSessionStateConnected) {
		_sessionConnected = YES;
		NSLog(@"Connected");
	}
}

@end










