//
//  YSShadedButton.m
//  ComplaintLetter
//
//  Created by Yair Szarf on 2/26/14.
//  Copyright (c) 2014 Yair Szarf. All rights reserved.
//

#import "YSShadedButton.h"

@implementation YSShadedButton



- (void) awakeFromNib {
    self.layer.cornerRadius = 5;
    self.layer.shadowOffset = CGSizeMake(1, 1);
    self.layer.shadowOpacity = 0.4;
    self.layer.shadowColor = [[UIColor blackColor] CGColor];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
