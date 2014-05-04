//
//  MBChatMessage.h
//  Mobster
//
//  Created by Yair Szarf on 5/4/14.
//  Copyright (c) 2014 2HC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MBUser.h"

@interface MBChatMessage : NSObject

@property (strong, nonatomic) MBUser * fromUser;
@property (strong, nonatomic) NSString * message;
@property (strong, nonatomic) NSDate * timestamp;
@property (nonatomic) BOOL other;

@end
