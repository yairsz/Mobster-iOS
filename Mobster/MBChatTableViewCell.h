//
//  MBOtherChatTableViewCell.h
//  Mobster
//
//  Created by Yair Szarf on 5/4/14.
//  Copyright (c) 2014 2HC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MBChatTableViewCell : UITableViewCell

@property (weak,nonatomic) IBOutlet UILabel * messageLabel;
@property (weak,nonatomic) IBOutlet UIImageView * userIcon;

@end
