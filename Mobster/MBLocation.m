//
//  MBLocation.m
//  Mobster
//
//  Created by Yair Szarf on 5/3/14.
//  Copyright (c) 2014 2HC. All rights reserved.
//

#import "MBLocation.h"

@implementation MBLocation

- (MBLocation *) initWithLat:(CGFloat) lat lon:(CGFloat)lon
{
    if (self = [super init]){
        _latitude = lat;
        _longitude = lon;
        
    }
    return self;
}

- (CLLocationCoordinate2D) coordinate2D
{
    return CLLocationCoordinate2DMake(self.latitude, self.longitude);
}


- (NSString *) description
{
    NSMutableString * descriptionString = [NSMutableString new];
    [descriptionString appendFormat:@"%f\n",self.latitude];
    [descriptionString appendFormat:@"%f\n",self.longitude];
    return  descriptionString;
}

@end
