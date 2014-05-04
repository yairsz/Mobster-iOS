//
//  MBSocketController.m
//  Mobster
//
//  Created by Yair Szarf on 5/3/14.
//  Copyright (c) 2014 2HC. All rights reserved.
//

#import "MBSocketController.h"
#import <socket.IO/SocketIOPacket.h>

@interface MBSocketController () <SocketIODelegate>

@end

@implementation MBSocketController

- (MBSocketController *) init {
    if (self = [super init]) {
        self.socketIO = [[SocketIO alloc] initWithDelegate:self];
        [self.socketIO connectToHost:@"107.170.141.208" onPort:1337];
        [self.socketIO sendEvent:@"init" withData:@{@"userId":@1,@"lat":@33,@"lon":@100} andAcknowledge:^(id argsData) {
            NSLog(@"INIT ACKNOWLEDGE%@",argsData);
        }];
    }
    return self;
}

#pragma mark - SocketIODelegate

- (void)socketIO:(SocketIO *)socket onError:(NSError *)error
{
    NSLog(@"%@", error.localizedDescription);
}

- (void)socketIO:(SocketIO *)socket didReceiveMessage:(SocketIOPacket *)packet {
//    NSLog(@"%@",packet);
    
}

- (void)socketIO:(SocketIO *)socket didReceiveEvent:(SocketIOPacket *)packet
{
    NSData * responseData = [packet.data dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary * JSONResponseDict = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:nil];
    [self.delegate didRecieveEvent:packet.name withData:JSONResponseDict];

        
}

- (void) socketIO:(SocketIO *)socket failedToConnectWithError:(NSError *)error
{
    NSLog(@"%@", error.localizedDescription);
}

- (void) sendChatMessageWithData:(NSDictionary*) data
{
    [self.socketIO sendEvent:CHAT_EVENT_NAME
                    withData:data
              andAcknowledge:^(id argsData) {
    }];
}


//- (void)sendStatusToLectureNotesServer:(StatusType)status
//{
//    // Send my current status to the Lecture Notes server
//
//    [self.socketIO sendEvent:@"msg" withData:@{ @"msg": statusTypeString, @"name": @"" } andAcknowledge:^(id argsData) {
//        
//    }];
//}


@end
