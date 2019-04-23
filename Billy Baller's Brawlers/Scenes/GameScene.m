//
//  GameScene.m
//  Billy Baller's Brawlers
//
//  Created by Nick Abate on 2/6/19.
//  Copyright © 2019 Nick Abate. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import <MultipeerConnectivity/MultipeerConnectivity.h>

#import "GameScene.h"
#import "Background.h"
#import "Bullet.h"
#import "ThrowingStar.h"
#import "StarPiece.h"
#import "GameServicer.h"
#import "Grenade.h"
#import "MenuScene.h"

@implementation GameScene {
    NSTimeInterval _lastUpdateTime;
}

- (void)sceneDidLoad {

	_lastUpdateTime = 0;
	
	_opponent = NULL;
	
	_playerDataSentCount = 0;
	
	_gameServicer = [[GameServicer alloc] initWithScene:self];
	
	_isHost = NO;
	_hostGameButton = [SKSpriteNode spriteNodeWithColor:[UIColor colorWithWhite:0 alpha:1] size:HOST_GAME_BUTTON_SIZE];
	[_hostGameButton setPosition:HOST_GAME_BUTTON_POSITION];
	[_hostGameButton setZPosition:1];
	[self addChild:_hostGameButton];
	SKLabelNode *hostLabel = [SKLabelNode labelNodeWithText:@"Host Game"];
	[hostLabel setFontName:@"AvenirNext-Bold"];
	[hostLabel setFontSize:40];
	[hostLabel setFontColor:[UIColor colorWithWhite:1 alpha:1]];
	[_hostGameButton addChild:hostLabel];
	_joinGameButton = [SKSpriteNode spriteNodeWithColor:[UIColor colorWithWhite:0 alpha:1] size:JOIN_GAME_BUTTON_SIZE];
	[_joinGameButton setPosition:JOIN_GAME_BUTTON_POSITION];
	[_joinGameButton setZPosition:1];
	[self addChild:_joinGameButton];
	SKLabelNode *joinLabel = [SKLabelNode labelNodeWithText:@"Join Game"];
	[joinLabel setFontName:@"AvenirNext-Bold"];
	[joinLabel setFontSize:40];
	[joinLabel setFontColor:[UIColor colorWithWhite:1 alpha:1]];
	[_joinGameButton addChild:joinLabel];
	_GameStarted = NO;
	
	self.physicsWorld.contactDelegate = self;
	self.contactQueue = [NSMutableArray array];
	_contactQueue = [NSMutableArray array];
	SceneContactDelegate = self;
	
	self.window = [SKSpriteNode spriteNodeWithTexture:NULL size:CGSizeMake(2000, 2000)];
	[self.window setPosition:CGPointMake(0, 0)];
	[self addChild:self.window];
	
	[self setBackgroundColor:[UIColor colorWithWhite:0.5 alpha:1]];
	
	_background = [Background backgroundWithImageNamed:@"Background" addTo:self];
	[_background setZPosition:0];
	[self addChild:_background];
	
	_gameOver = NO;
	_youLoseAnimation = [YouLoseAnimation youLoseAnimation:YOU_LOSE_STATIC_ID];
	_youWinAnimation = [YouWinAnimation youWinAnimation:YOU_WIN_STATIC_ID];
	
}

- (void) spawnPlayer:(int)brawlerIdIn {

	_player = [Player brawlerWithID:brawlerIdIn isOpponent:NO withServicer:_gameServicer];
	_player.gameScene = self;
	[self addChild:_player];
	
	_playerControls = [PlayerControls controlsForPlayer:_player withServicer:_gameServicer];
	[self addChild:_playerControls];
	
}

- (void) didBeginContact:(SKPhysicsContact *)contact {
	[self.contactQueue addObject:contact];
}

- (void)processContactsForUpdate:(NSTimeInterval)currentTime {
	for (SKPhysicsContact* contact in [self.contactQueue copy]) {
		[self handleContact:contact];
        [self.contactQueue removeObject:contact];
    }
}

- (void) handleContact:(SKPhysicsContact *)contact {
	if (!contact.bodyA.node.parent || !contact.bodyB.node.parent) {
		return;
	}
	NSString *nameA = contact.bodyA.node.name;
	NSString *nameB = contact.bodyB.node.name;
	NSString *opponentBulletStr = [bulletName stringByAppendingString:OPPONENT_POSTFIX];
	if ([nameA isEqualToString:wallName] && [nameB isEqualToString:bulletName]) {
		[contact.bodyB.node removeFromParent];
	} else if ([nameA isEqualToString:wallName] && [nameB isEqualToString:bulletName]) {
		[contact.bodyA.node removeFromParent];
	} else if ([nameA isEqualToString:opponentBulletStr] && [nameB isEqualToString:wallName]) {
		[contact.bodyA.node removeFromParent];
	} else if ([nameA isEqualToString:wallName] && [nameB isEqualToString:opponentBulletStr]) {
		[contact.bodyB.node removeFromParent];
	}
	else if ([nameA isEqualToString:playerName] || [nameB isEqualToString:playerName]) {
	
		NSLog(@"contact with player");
	
		NSString *nameToCheck;
		BOOL isNameA = NO;
		if ([nameA isEqualToString:playerName]) {
			nameToCheck = nameB;
		} else {
			nameToCheck = nameA;
			isNameA = YES;
		}
		
		// Bullet Section
		NSString *bulletSection = @"";
		NSString *postfix = @"";
		@try {
			bulletSection = [nameToCheck substringToIndex:bulletName.length];
			postfix = [nameToCheck substringFromIndex:bulletName.length];
		}
		@catch (NSException *e)  {
			
		}
		@finally {
		
		}
		if ([bulletSection isEqualToString:bulletName] && [postfix isEqualToString:OPPONENT_POSTFIX]) {
			if (_opponent.brawlerID == BILLY_ID) {
				[_player takeDamage:BILLY_BULLET_DAMAGE];
			} else if (_opponent.brawlerID == STEVE_ID) {
				[_player takeDamage:STEVE_BULLET_DAMAGE];
			}
			NSString *numStr = [[NSNumber numberWithInt:_player.healthBar.currentHealth] stringValue];
			NSString *data = [HEALTH_UPDATE_PREFIX stringByAppendingString:numStr];
			[_gameServicer sendData:data];
			if (isNameA) {
				[contact.bodyA.node removeFromParent];
			} else {
				[contact.bodyB.node removeFromParent];
			}
			return;
		}
		
		// Explosion Section
		NSString *explosionSection = @"";
		@try {
			explosionSection = [nameToCheck substringToIndex:explosionName.length];
			postfix = [nameToCheck substringFromIndex:explosionName.length];
		}
		@catch (NSException *e) {
			
		}
		@finally {
		
		}
		
		if ([explosionSection isEqualToString:explosionName] && [postfix isEqualToString:OPPONENT_POSTFIX]) {
			[_player takeDamage:GRENADE_DAMAGE];
			NSString *numStr = [[NSNumber numberWithInt:_player.healthBar.currentHealth] stringValue];
			NSString *data = [HEALTH_UPDATE_PREFIX stringByAppendingString:numStr];
			[_gameServicer sendData:data];
			if (isNameA) {
				contact.bodyA.node.name = @"invalid";
			} else {
				contact.bodyB.node.name = @"invalid";
			}
			return;
		}
		
		if (isNameA) {
			[self checkSlimeContact:nameToCheck atPoint:contact.bodyA.node.position];
		} else {
			[self checkSlimeContact:nameToCheck atPoint:contact.bodyB.node.position];
		}
		
		[self checkThrowingStarContact:contact checkingName:nameToCheck isNameA:isNameA];
		
		[self checkStarPieceContact:contact checkingName:nameToCheck isNameA:isNameA];
		
		[self checkSniperBulletContact:contact checkingName:nameToCheck isNameA:isNameA];
		
	} else if ([nameA isEqualToString:opponentName] || [nameB isEqualToString:opponentName]) {
		NSString *nameToCheck;
		BOOL isNameA = NO;
		if ([nameA isEqualToString:opponentName]) {
			nameToCheck = nameB;
		} else {
			nameToCheck = nameA;
			isNameA = YES;
		}

		if ([nameToCheck isEqualToString:bulletName]) {
			if (isNameA) {
				[contact.bodyA.node removeFromParent];
			} else {
				[contact.bodyB.node removeFromParent];
			}
			return;
		} else if ([nameToCheck isEqualToString:throwingStarName]) {
			if (isNameA) {
				[contact.bodyA.node removeFromParent];
			} else {
				[contact.bodyB.node removeFromParent];
			}
		} else if ([nameToCheck isEqualToString:starPieceName]) {
			if (isNameA) {
				[contact.bodyA.node removeFromParent];
			} else {
				[contact.bodyB.node removeFromParent];
			}
		} else if ([nameToCheck isEqualToString:sniperBulletName]) {
			if (isNameA) {
				[contact.bodyA.node removeFromParent];
			} else {
				[contact.bodyB.node removeFromParent];
			}
		}
	}


}

- (void) checkSlimeContact:(NSString *)nameToCheck atPoint:(CGPoint)point {
	NSString *slimeNameStr = @"";
	NSString *postfix = @"";
	@try {
		slimeNameStr = [nameToCheck substringToIndex:slimeName.length];
		postfix = [nameToCheck substringFromIndex:slimeName.length];
	}
	@catch (NSException *e) {
		return;
	}
	@finally {
		
	}
	if ([slimeNameStr isEqualToString:slimeName]) {
		Direction dir = East;
		if (point.x <= 0) {
			dir = West;
		}
		if ([postfix isEqualToString:OPPONENT_POSTFIX]) {
			[_playerControls slidePlayerInDirection:dir];
		}
	}
}

- (void) checkThrowingStarContact:(SKPhysicsContact *)contact checkingName:(NSString *)nameToCheck isNameA:(BOOL)isNameA {
	NSString *throwingStarStr = @"";
	NSString *postfix = @"";
	@try {
		throwingStarStr = [nameToCheck substringToIndex:throwingStarName.length];
		postfix = [nameToCheck substringFromIndex:throwingStarName.length];
	}
	@catch (NSException *e) {
		return;
	}
	@finally {
	
	}
	
	if ([throwingStarStr isEqualToString:throwingStarName] && [postfix isEqualToString:OPPONENT_POSTFIX]) {
		[_player takeDamage:THROWING_STAR_DAMAGE];
		NSString *numStr = [[NSNumber numberWithInt:_player.healthBar.currentHealth] stringValue];
		NSString *data = [HEALTH_UPDATE_PREFIX stringByAppendingString:numStr];
		[_gameServicer sendData:data];
		if (isNameA) {
			[contact.bodyA.node removeFromParent];
		} else {
			[contact.bodyB.node removeFromParent];
		}
	}
	
}

- (void) checkStarPieceContact:(SKPhysicsContact *)contact checkingName:(NSString *)nameToCheck isNameA:(BOOL)isNameA {
	NSString *starPieceStr = @"";
	NSString *postfix = @"";
	@try {
		starPieceStr = [nameToCheck substringToIndex:starPieceName.length];
		postfix = [nameToCheck substringFromIndex:starPieceName.length];
	}
	@catch (NSException *e) {
		return;
	}
	@finally {
	
	}
	
	if ([starPieceStr isEqualToString:starPieceName] & [postfix isEqualToString:OPPONENT_POSTFIX]) {
		
		[_player takeDamage:STAR_PIECE_DAMAGE];
		NSString *numStr = [[NSNumber numberWithInt:_player.healthBar.currentHealth] stringValue];
		NSString *data = [HEALTH_UPDATE_PREFIX stringByAppendingString:numStr];
		[_gameServicer sendData:data];
		if (isNameA) {
			[contact.bodyA.node removeFromParent];
		} else {
			[contact.bodyB.node removeFromParent];
		}
	}
	
}

- (void) checkSniperBulletContact:(SKPhysicsContact *)contact checkingName:(NSString *)nameToCheck isNameA:(BOOL)isNameA {

}

- (void)touchDownAtPoint:(CGPoint)pos {
}

- (void)touchMovedToPoint:(CGPoint)pos {
}

- (void)touchUpAtPoint:(CGPoint)pos {
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	UITouch *touch = [touches anyObject];
	CGPoint point = [touch locationInNode:self.window];
	if (!_GameStarted) {
		if ([_hostGameButton containsPoint:point]) {
			[_hostGameButton removeFromParent];
			[_joinGameButton removeFromParent];
			[_gameServicer hostGame];
			_isHost = YES;
		} else if ([_joinGameButton containsPoint:point]) {
			[_hostGameButton removeFromParent];
			[_joinGameButton removeFromParent];
			[_gameServicer joinGame];
		}
		return;
	} else {
		[_playerControls checkControlsDown:point];
	}
}
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
	if (!_GameStarted) {
		return;
	}
	UITouch *touch = [touches anyObject];
	CGPoint point = [touch locationInNode:self.window];
	[_playerControls checkControlsMoved:point];
}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
	if (!_GameStarted) {
		return;
	}
	UITouch *touch = [touches anyObject];
	CGPoint point = [touch locationInNode:self.window];
	[_playerControls checkControlsUp:point];
}
- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {

}

- (void) sendPlayerID {
	NSString *stringData = [OPPONENT_PREFIX stringByAppendingString:[[NSNumber numberWithInt:_player.brawlerID] stringValue]];
	[_gameServicer sendData:stringData];
}

- (BOOL)spawnOpponent:(NSData *)data {
	NSLog(@"checking spaawn data");
	// Getting player data
	NSString *dataStr = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
	NSString *opponentPrefix;
	NSString *opponentBrawlerID;
	@try {
		opponentPrefix = [dataStr substringToIndex:OPPONENT_PREFIX.length];
		opponentBrawlerID = [dataStr substringFromIndex:OPPONENT_PREFIX.length];
	}
	@catch (NSException *e) {
		return false;
	}
	int opponentID = BILLY_ID;
	if ([opponentPrefix isEqualToString:OPPONENT_PREFIX]) {
		opponentID = [opponentBrawlerID intValue];
	}
	
	_opponent = [Player brawlerWithID:opponentID isOpponent:YES withServicer:_gameServicer];
	[self addChild:_opponent];
	_opponentControls = [PlayerControls controlsForPlayer:_opponent withServicer:_gameServicer];
	_opponent.gameScene = self;
	
	return true;
	
}

- (void)checkOpponentData:(NSData *)data {
	if (_opponent != NULL) {
		[_opponent.healthBar checkData:data];
		[_opponentControls performActionFromData:data];
	} else if (_opponent == NULL) {
		if ([self spawnOpponent:data]) {
			_GameStarted = YES;
			[self sendPlayerID];
		}
	}
}

- (void)loseGame {
	_gameOver = YES;
	[self addChild:_youLoseAnimation];
	[_youLoseAnimation start];
}

- (void)winGame {
	_gameOver = YES;
	[self addChild:_youWinAnimation];
	[_youWinAnimation start];
}

- (void) unslidePlayer:(BOOL)isOpponent {
	if (isOpponent) {
		_opponent.isSlidding = NO;
	} else {
		_player.isSlidding = NO;
	}
}

- (void)update:(CFTimeInterval)currentTime {
    // Called before each frame is rendered
	
    // Initialize _lastUpdateTime if it has not already been
    if (_lastUpdateTime == 0) {
        _lastUpdateTime = currentTime;
    }
	
    [self processContactsForUpdate:currentTime];
    
    // Calculate time since last update
    CGFloat dt = currentTime - _lastUpdateTime;
	
	if (_gameOver) {
		if (dt > 60.0 * 3.0) {
			NSLog(@"Restart game");
		}
	}
    else if (_opponent == NULL && dt > 1.0/60.0) {
    	_lastUpdateTime = currentTime;
    	if (_gameServicer.sessionConnected && !_GameStarted) {
    		[self sendPlayerID];
		}
	}
	else if (dt > 1.0/60.0) {
		_lastUpdateTime = currentTime;
		if (_player.healthBar.currentHealth == 0) {
			[self loseGame];
		} else if (_opponent != NULL && _opponent.healthBar.currentHealth == 0) {
			[self winGame];
		}
	}
    
    // Update entities
    for (GKEntity *entity in self.entities) {
        [entity updateWithDeltaTime:dt];
    }

}

@end
