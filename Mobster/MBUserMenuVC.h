//
//  MBUserMenuVCViewController.h
//  Mobster
//
//  Created by Yair Szarf on 4/24/14.
//  Copyright (c) 2014 2HC. All rights reserved.
//

#import "MBSuperVC.h"

@class MBChatMessage;

@interface MBUserMenuVC : MBSuperVC

- (void) didReceiveChatMessage:(MBChatMessage *) chatMessage;

@end
