//
//  AddNoteViewController.h
//  Balance
//
//  Created by Desmond Preston on 2/16/15.
//  Copyright (c) 2015 Desmond Preston. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EditorViewController.h"

@interface AddNoteViewController : UIViewController <EditorViewControllerDelegate, UITextFieldDelegate>

- (IBAction)createNoteButtonPressed:(id)sender;

@property (weak, nonatomic) NSManagedObject *item;
@property (weak, nonatomic) IBOutlet UILabel *itemNote;
@property (strong, nonatomic) IBOutlet UITextField *activityName;
@property (weak, nonatomic) IBOutlet UILabel *ThisTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *NextTimeLabel;
@property (strong, nonatomic) IBOutlet UIScrollView *ScrollView;
@property (weak, nonatomic) IBOutlet UILabel *futureItemNote;
@property (weak, nonatomic) IBOutlet UIButton *addThisTimeNote;
@property (weak, nonatomic) IBOutlet UIButton *addNextTimeNote;
@property (weak, nonatomic) IBOutlet UIButton *thisTimeOptions;
@property (weak, nonatomic) IBOutlet UIButton *nextTimeOptions;
- (IBAction)createBottomMenu:(id)sender;
@end
