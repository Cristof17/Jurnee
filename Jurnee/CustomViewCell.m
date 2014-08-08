//
//  CustomViewCell.m
//  Jurnee
//
//  Created by ios on 8/8/14.
//  Copyright (c) 2014 Cristof. All rights reserved.
//

#import "CustomViewCell.h"

@implementation CustomViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
