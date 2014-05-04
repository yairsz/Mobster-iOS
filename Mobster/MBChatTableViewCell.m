//
//  MBOtherChatTableViewCell.m
//  Mobster
//
//  Created by Yair Szarf on 5/4/14.
//  Copyright (c) 2014 2HC. All rights reserved.
//

#import "MBChatTableViewCell.h"

@implementation MBChatTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
