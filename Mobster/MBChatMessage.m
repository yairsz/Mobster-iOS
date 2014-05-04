//
//  MBChatMessage.m
//  Mobster
//
//  Created by Yair Szarf on 5/4/14.
//  Copyright (c) 2014 2HC. All rights reserved.
//

#import "MBChatMessage.h"

@implementation MBChatMessage


- (NSString *) description
{
    NSMutableString * descriptionString = [NSMutableString new];
    [descriptionString appendFormat:@"user:%@  ",self.fromUser];
    [descriptionString appendFormat:@"Message%@  ",self.message];
    return  descriptionString;
}
@end
