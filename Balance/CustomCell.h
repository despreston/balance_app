//
//  CustomCell.h
//  Balance
//
//  Created by Desmond Preston on 5/31/15.
//  Copyright (c) 2015 Desmond Preston. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *name;
@property (strong, nonatomic) IBOutlet UILabel *lastText;
@property (strong, nonatomic) IBOutlet UILabel *nextText;
@property (strong, nonatomic) IBOutlet UILabel *lastUpdatedText;
@property (strong, nonatomic) IBOutlet UIView *cellView;
@property (strong, nonatomic) IBOutlet UIView *content;

@end
