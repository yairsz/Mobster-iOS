//
//  MBLocation.h
//  Mobster
//
//  Created by Yair Szarf on 5/3/14.
//  Copyright (c) 2014 2HC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface MBLocation : NSObject
/**
 * Coordinate pair: Latitude, Longitude
 **/
@property (nonatomic) CGFloat latitude;
@property (nonatomic) CGFloat longitude;
@property (nonatomic) CLLocationCoordinate2D coordinate2D;
@property (strong,nonatomic) NSDate * timestamp;


- (MBLocation *) initWithLat:(CGFloat) lat lon:(CGFloat)lon;
@end
