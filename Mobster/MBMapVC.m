//
//  MBMapViewController.m
//  Mobster
//
//  Created by Yair Szarf on 4/24/14.
//  Copyright (c) 2014 2HC. All rights reserved.
//

#import "MBMapVC.h"
#import "MBUserMenuVC.h"
#import "MBChatMessage.h"

@interface MBMapVC () <GMSMapViewDelegate>
@property (weak,nonatomic) IBOutlet GMSMapView * mapView;
@property (weak,nonatomic) IBOutlet UIButton * burgerButton;
@property (weak,nonatomic) IBOutlet UIButton * userButton;
@property (strong,nonatomic) CLLocationManager * locationManager;
@property (strong,nonatomic) NSMutableDictionary * users;
@property (strong,nonatomic) NSMutableDictionary * markers;

@end



@implementation MBMapVC
{

    BOOL firstLocationUpdate_;
    MBUserMenuVC * chatVC;
    MBSocketController * socketController;
    
}


- (void)viewDidLoad {
    // Create a GMSCameraPosition that tells the map to display the
    // coordinate -33.86,151.20 at zoom level 6.
    socketController = [[MBSocketController alloc] init];
    socketController.delegate = self;
    self.socketController = socketController;
    chatVC = (MBUserMenuVC*) self.revealViewController.rearViewController;
    
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:-33.86
                                                            longitude:151.20
                                                                zoom:14];
    self.mapView.camera = camera;
    self.mapView.settings.compassButton = YES;
    self.mapView.settings.myLocationButton = YES;
    self.mapView.myLocationEnabled = YES;
    
    [self.mapView addObserver:self
               forKeyPath:@"myLocation"
                  options:NSKeyValueObservingOptionNew
                  context:NULL];
    // Creates a marker in the center of the map.

    
    self.locationManager = [[CLLocationManager alloc] init];
    [self.locationManager setDelegate:self];
    [self.locationManager setDistanceFilter:10];
    [self.locationManager setDesiredAccuracy:kCLLocationAccuracyNearestTenMeters];
    [self.locationManager startUpdatingLocation];
    
    
    
    dispatch_async(dispatch_get_main_queue(), ^{
        self.mapView.myLocationEnabled = YES;
//        NSLog(@"User's location: %@", self.mapView.myLocation);
    });
    
    

}

#pragma mark Setters and Getters

- (NSMutableDictionary *) users
{
    if (!_users) {
        _users = [NSMutableDictionary new];
    }
    return _users;
}

- (NSMutableDictionary *) markers
{
    if (!_markers) {
        _markers = [NSMutableDictionary new];
    }
    return _markers;
}



#pragma mark - CLLocationMangerDelegate

- (void) locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)pressedBurger:(UIButton *) sender
{
    [self.revealViewController rightRevealToggle:sender];
    self.mapView = nil;
}

- (IBAction)pressedUserButton:(UIButton *) sender
{
    [self.revealViewController revealToggle:sender];
    self.mapView = nil;
}

- (void)dealloc {
    [self.mapView removeObserver:self
                  forKeyPath:@"myLocation"
                     context:NULL];
}

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context {
    if ([keyPath isEqualToString:@"myLocation"]){
            // If the first location update has not yet been recieved, then jump to that
            // location.
        if (!firstLocationUpdate_) {
            firstLocationUpdate_ = YES;
            CLLocation *location = [change objectForKey:NSKeyValueChangeNewKey];
            self.mapView.camera = [GMSCameraPosition cameraWithTarget:location.coordinate
                                                             zoom:self.mapView.camera.zoom];
        }
        
    }
}

- (void) addMarkerForUser: (MBUser *) user
{
    GMSMarker *marker = [[GMSMarker alloc] init];
    marker.position = user.currentLocation.coordinate2D;
    marker.icon = [UIImage imageNamed:@"genericmarker"];
    marker.map = self.mapView;
    marker.appearAnimation = kGMSMarkerAnimationPop;
    marker.tappable = YES;
    [self.markers setValue:marker forKey:user.userID];
}


- (void) didRecieveEvent:(NSString *)eventName withData:(NSDictionary *)data
{
    NSLog(@"event name:%@\nDATA: %@",eventName,data);
    NSArray * userDicts = [data objectForKey:@"args"];
    
    if ([eventName isEqualToString:UPDATE_EVENT_NAME]){
        {
            NSDictionary * userDict=  userDicts[0];
            MBLocation * newLocation = [[MBLocation alloc] initWithLat:[userDict[LATITUDE_KEY] floatValue]
                                                                   lon:[userDict[LONGITUDE_KEY] floatValue]];
            NSString * updateUserId = [[userDict objectForKey:USERID_KEY] stringValue];
            MBUser * existingUser = [self.users valueForKey:updateUserId];
            if (existingUser) {
                existingUser.currentLocation = newLocation;
                GMSMarker * marker = [self.markers objectForKey:existingUser.userID];
                marker.position = newLocation.coordinate2D;
            } else {
//                [self addMarkerForUser:user];
            }
        }
    }
    if ([eventName isEqualToString:INIT_EVENT_NAME]) {
        userDicts = [data objectForKey:@"args"][0];
        for (NSDictionary * userDict in userDicts) {
            MBUser * user = [self userFromDictionary:userDict];
            [self.users setValue:user forKey:user.userID];
            [self addMarkerForUser:user];
        }
    }
    if ([eventName isEqualToString:CHAT_EVENT_NAME]) {
        NSDictionary * userDict = userDicts[0];
        MBChatMessage * chatMessage = [[MBChatMessage alloc] init];
        chatMessage.fromUser = (MBUser*)[self.users valueForKey:@"12"];//TODO:change to actual userID from corrected chat event
        chatMessage.message = userDict[@"msg"];
        chatMessage.timestamp = [NSDate date];
        chatMessage.other = YES;
        [chatVC didReceiveChatMessage:chatMessage];
    }
    if ([eventName isEqualToString:NEW_USER_EVENT_NAME]) {
        NSDictionary * userDict = userDicts[0];
        MBUser * user = [self userFromDictionary:userDict];
        [self.users setValue:user forKey:user.userID];
        [self addMarkerForUser:user];
    }
    
    
    


}

- (MBUser *) userFromDictionary:(NSDictionary *) userDict
{
    MBUser *user = [self.users valueForKey:userDict[USERNAME_KEY]];
    if (!user)
    {
        user = [[MBUser alloc] init];
        user.userID = [userDict[USERID_KEY] stringValue];
    
        MBLocation * location = [[MBLocation alloc] init];
        location.latitude = [userDict[LOCATION_KEY][0][LATITUDE_KEY] floatValue];
        location.longitude = [userDict[LOCATION_KEY][0][LONGITUDE_KEY] floatValue];
        user.currentLocation = location;
        
        [self.users setValue:user forKey:user.userID];
    }
    return user;
}

- (BOOL)mapView:(GMSMapView *)mapView didTapMarker:(GMSMarker *)marker
{
    return TRUE;
}


@end
