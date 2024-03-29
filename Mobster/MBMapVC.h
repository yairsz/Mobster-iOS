//
//  MBMapViewController.h
//  Mobster
//
//  Created by Yair Szarf on 4/24/14.
//  Copyright (c) 2014 2HC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GoogleMaps/GoogleMaps.h>
#import <CoreLocation/CoreLocation.h>
#import "MBSocketController.h"

typedef enum {
    MBMarkerTypeHot = 0,
    MBMarkerTypePolice,
    MBMarkerTypeEmergency
} MBMarkerType;


@interface MBMapVC : MBSuperVC <CLLocationManagerDelegate,MBSocketControllerDelegate>

@property (strong, nonatomic) MBSocketController * socketController;

- (void) addMarkerOfType: (MBMarkerType) markerType;
@end
