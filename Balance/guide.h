//
//  guide.h
//  Balance
//
//  Created by Desmond Preston on 8/19/15.
//  Copyright (c) 2015 Desmond Preston. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface guide : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *question1;
@property (weak, nonatomic) IBOutlet UILabel *question2;
@property (weak, nonatomic) IBOutlet UILabel *label1;
@property (strong, nonatomic) IBOutlet UITapGestureRecognizer *guideTapGesture;

@end
