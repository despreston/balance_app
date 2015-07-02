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

@property (strong, nonatomic) NSManagedObject *item;
@property (strong, nonatomic) IBOutlet UILabel *itemNote;
@property (strong, nonatomic) IBOutlet UITextField *activityName;
@property (strong, nonatomic) IBOutlet UILabel *ThisTimeLabel;
@property (strong, nonatomic) IBOutlet UILabel *NextTimeLabel;
@property (strong, nonatomic) IBOutlet UIScrollView *ScrollView;
@property (strong, nonatomic) IBOutlet UILabel *futureItemNote;
@property (strong, nonatomic) IBOutlet UIButton *addThisTimeNote;
@property (strong, nonatomic) IBOutlet UIButton *addNextTimeNote;
- (IBAction)createBottomMenu:(id)sender;
@end
