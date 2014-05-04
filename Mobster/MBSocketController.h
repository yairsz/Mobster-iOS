//
//  MBSocketController.h
//  Mobster
//
//  Created by Yair Szarf on 5/3/14.
//  Copyright (c) 2014 2HC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <socket.IO/SocketIO.h>

@protocol MBSocketControllerDelegate <NSObject>

- (void) didRecieveEvent:(NSString *) eventName withData:(NSDictionary *) data;

@end

@interface MBSocketController : NSObject

@property (nonatomic, strong) SocketIO *socketIO;
@property (unsafe_unretained) id <MBSocketControllerDelegate> delegate;

- (void) sendChatMessageWithData:(NSDictionary*) data;

@end
