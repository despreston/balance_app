//
//  AddNoteViewController.h
//  Balance
//
//  Created by Desmond Preston on 2/16/15.
//  Copyright (c) 2015 Desmond Preston. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddNoteViewController : UIViewController <UITextViewDelegate>

- (IBAction)save:(id)sender;
- (IBAction)activityNameInputChange:(id)sender;

@property (weak, nonatomic) IBOutlet UITextView *itemNote;
@property (strong, nonatomic) IBOutlet UITextField *activityName;
@property (strong, nonatomic) IBOutlet UILabel *activityLabel;
@property (strong, nonatomic) IBOutlet UILabel *ThisTimeLabel;
@property (strong, nonatomic) IBOutlet UILabel *NextTimeLabel;
@property (strong, nonatomic) IBOutlet UIScrollView *ScrollView;
@property (strong, nonatomic) IBOutlet UITextView *futureItemNote;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *SaveButton;

@end
