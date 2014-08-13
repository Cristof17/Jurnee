//
//  CustomViewCell.h
//  Jurnee
//
//  Created by ios on 8/8/14.
//  Copyright (c) 2014 Cristof. All rights reserved.
//

#import <UIKit/UIKit.h>
#include "SWTableViewCell.h"
#import <AssetsLibrary/AssetsLibrary.h>

@interface CustomViewCell : SWTableViewCell
<SWTableViewCellDelegate>

@property (weak ,nonatomic )IBOutlet UIImageView * imageView ;
@property IBOutlet UILabel * label ;
@property IBOutlet UIButton * buttonText;
@property IBOutlet UIButton * buttonImage;



@end
