//
//  CustomCell.m
//  Balance
//
//  Created by Desmond Preston on 5/31/15.
//  Copyright (c) 2015 Desmond Preston. All rights reserved.
//

#import "CustomCell.h"

@implementation CustomCell

@synthesize contentView;

- (void)awakeFromNib {
    // Initialization code
    
    self.contentView.layer.borderColor = [[UIColor colorWithRed:215.0f/255.0f green:215.0f/255.0f blue:215.0f/255.0f alpha:1.0] CGColor];
    self.contentView.layer.shadowColor = [[UIColor colorWithRed:240.0f/255.0f green:240.0f/255.0f blue:240.0f/255.0f alpha:1.0] CGColor];
    self.contentView.layer.shadowPath = [[UIBezierPath bezierPathWithRect:self.contentView.layer.bounds] CGPath];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
