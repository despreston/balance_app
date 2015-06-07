//
//  AddNoteViewController.h
//  Balance
//
//  Created by Desmond Preston on 2/16/15.
//  Copyright (c) 2015 Desmond Preston. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddNoteViewController : UIViewController

- (IBAction)save:(id)sender;
- (IBAction)editNoteButtonPressed:(id)sender;
- (IBAction)activityNameInputChange:(id)sender;

@property (strong) NSManagedObject *item;
@property (weak, nonatomic) IBOutlet UILabel *itemNote;
@property (strong, nonatomic) IBOutlet UITextField *activityName;
@property (strong, nonatomic) IBOutlet UILabel *ThisTimeLabel;
@property (strong, nonatomic) IBOutlet UILabel *NextTimeLabel;
@property (strong, nonatomic) IBOutlet UIScrollView *ScrollView;
@property (strong, nonatomic) IBOutlet UILabel *futureItemNote;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *SaveButton;
@property (strong, nonatomic) IBOutlet UIButton *addThisTimeNote;
@property (strong, nonatomic) IBOutlet UIButton *addNextTimeNote;
@end
