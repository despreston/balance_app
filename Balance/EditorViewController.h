//
//  EditorViewController.h
//  Balance
//
//  Created by Desmond Preston on 6/5/15.
//  Copyright (c) 2015 Desmond Preston. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EditorViewController : UIViewController <UITextViewDelegate>

- (IBAction)Done:(id)sender;
- (IBAction)ClearButtonPressed:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *Cancel;
@property (strong, nonatomic) IBOutlet UITextView *note;
@property (strong, nonatomic) IBOutlet UIButton *Done;
@property (strong, nonatomic) NSString *passedNote;
@property (strong, nonatomic) IBOutlet UIButton *ClearButton;



@end
