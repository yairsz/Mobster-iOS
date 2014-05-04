//
//  MBActionsMenuVC.m
//  Mobster
//
//  Created by Yair Szarf on 4/24/14.
//  Copyright (c) 2014 2HC. All rights reserved.
//

#import "MBActionsMenuVC.h"
#import "MBMapVC.h"

@interface MBActionsMenuVC ()

@end

@implementation MBActionsMenuVC
{
    MBMapVC * mapVC;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    mapVC =(MBMapVC*) [self.revealViewController frontViewController];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)setMarker: (UIButton*) sender
{
    [mapVC addMarkerOfType:sender.tag];
}

@end
