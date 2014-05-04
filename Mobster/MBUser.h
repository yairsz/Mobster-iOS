//
//  MBUser.h
//  Mobster
//
//  Created by Yair Szarf on 5/3/14.
//  Copyright (c) 2014 2HC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MBLocation.h"

@interface MBUser : NSObject
@property (strong,nonatomic) NSString * name;
@property (strong,nonatomic) NSString * userID;
/**
 * Array containing history of the users locations.  Most Recent is the last object
 **/
@property (strong,nonatomic) NSMutableArray * locationHistory;
@property (strong,nonatomic) MBLocation * currentLocation;
@property (strong,nonatomic) NSURL * iconURL;

@end
