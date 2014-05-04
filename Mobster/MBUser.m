//
//  MBUser.m
//  Mobster
//
//  Created by Yair Szarf on 5/3/14.
//  Copyright (c) 2014 2HC. All rights reserved.
//

#import "MBUser.h"

@implementation MBUser

- (NSMutableArray *) locationHistory
{
    if (!_locationHistory) {
        _locationHistory = [NSMutableArray new];
    }
    return _locationHistory;
}

- (void) setCurrentLocation:(MBLocation *)currentLocation
{
    _currentLocation = currentLocation;
    
    [self.locationHistory addObject:currentLocation];
}


- (NSString *) description
{
    NSMutableString * descriptionString = [NSMutableString new];
    [descriptionString appendFormat:@"name:%@  ",self.name];
    [descriptionString appendFormat:@"userID:%@  ",self.userID];
    [descriptionString appendFormat:@"Location:%@  ",self.currentLocation];
    return  descriptionString;
}
@end
