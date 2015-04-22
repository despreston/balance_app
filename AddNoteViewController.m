//
//  AddNoteViewController.m
//  ToDoList
//
//  Created by Desmond Preston on 2/16/15.
//  Copyright (c) 2015 Desmond Preston. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "AddNoteViewController.h"
#import "BAModel.h"
#import "BAItem.h"

@interface AddNoteViewController ()

@end

@implementation AddNoteViewController {
    BAModel *sharedManager;
    BAItem *loadedItem;
}

@synthesize itemNote;
@synthesize futureItemNote;
@synthesize activityName;
@synthesize ScrollView;

- (void)viewDidLoad {
    [super viewDidLoad];
    sharedManager = [BAModel sharedManager];
    
    self.itemNote.delegate = self;
    self.futureItemNote.delegate = self;
    
    if ([sharedManager activeItem] != nil) {
        loadedItem = [[sharedManager toDoItems] objectAtIndex:[[sharedManager activeItem] row]];
    } else {
        loadedItem = [[BAItem alloc]init];
    }
    
    // hide keyboard when clicking outside of textview
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];
    
    // populate fields with loadedItem data
    self.itemNote.text = loadedItem.thisTimeNote;
    self.futureItemNote.text = loadedItem.nextTimeNote;
    self.activityName.text = loadedItem.itemName;
    
    // Set Styles
    self.activityLabel.font = [UIFont fontWithName:@"HelveticaNeue-Medium" size: 17];
    self.activityName.font = [UIFont fontWithName:@"HelveticaNeue" size: 17];
    self.ThisTimeLabel.font = [UIFont fontWithName:@"HelveticaNeue-Medium" size: 17];
    self.NextTimeLabel.font = [UIFont fontWithName:@"HelveticaNeue-Medium" size: 17];
    
    self.itemNote.layer.borderWidth = 1.0f;
    self.itemNote.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    self.itemNote.layer.cornerRadius = 5;
    self.itemNote.font = [UIFont fontWithName:@"HelveticaNeue" size: 16];
    
    self.futureItemNote.layer.borderWidth = 1.0f;
    self.futureItemNote.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    self.futureItemNote.layer.cornerRadius = 5;
    self.futureItemNote.font = [UIFont fontWithName:@"HelveticaNeue" size: 16];
    
}

- (void)dismissKeyboard {
    [self.view endEditing:YES];
}

- (IBAction)save:(id)sender {
    loadedItem.thisTimeNote = self.itemNote.text;
    loadedItem.itemName = self.activityName.text;
    loadedItem.nextTimeNote = self.futureItemNote.text;
    
    if (sharedManager.activeItem == nil) {
        [[sharedManager toDoItems] addObject:loadedItem];
    }
    else if (sharedManager.activeItem != nil) {
        [[sharedManager toDoItems] replaceObjectAtIndex:[[sharedManager activeItem] row] withObject:loadedItem];
    }
    
    [self performSegueWithIdentifier:@"unwindToMainMenu" sender:self];
}

- (IBAction)activityNameInputChange:(id)sender {
    [self checkForDirty];
}

- (void)textViewDidChange:(UITextView *)textView {
    [self checkForDirty];
}

- (void)checkForDirty {
    // make sure the activity name is not blank before checking for dirty fields
    if (![self.activityName.text isEqual:@""]) {
        if (![self.activityName.text isEqual:loadedItem.itemName] || ![self.itemNote.text isEqual:loadedItem.thisTimeNote] || ![self.futureItemNote.text isEqual:loadedItem.nextTimeNote]) {
            self.SaveButton.enabled = YES;
        }
    } else {
        self.SaveButton.enabled = NO;
    }
}

@end
