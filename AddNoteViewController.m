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

- (void)viewDidLoad {
    [super viewDidLoad];
    sharedManager = [BAModel sharedManager];
    
    self.itemNote.delegate = self;
    self.futureItemNote.delegate = self;
    
    // either load data from todoItems or if its a new item, initialize it.
    if ([sharedManager activeItem] != nil) {
        loadedItem = [[sharedManager toDoItems] objectAtIndex:[[sharedManager activeItem] row]];
    } else {
        loadedItem = [[BAItem alloc]init];
        [self.activityName becomeFirstResponder];
    }
    
    UITapGestureRecognizer *thisTimeClearButtonTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clearThisTime)];
    [self.ThisTimeClearButton addGestureRecognizer:thisTimeClearButtonTap];
    
    // Activity name notification
    [self.activityName addTarget:self action:@selector(activityNameSelected)forControlEvents:UIControlEventEditingDidBegin];
    [self.activityName addTarget:self action:@selector(activityNameDeSelected)forControlEvents:UIControlEventEditingDidEnd];
    
    // hide keyboard when clicking outside of textview
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];
    
    // populate fields with loadedItem data
    self.itemNote.text = loadedItem.thisTimeNote;
    self.futureItemNote.text = loadedItem.nextTimeNote;
    self.activityName.text = loadedItem.itemName;
    
    // Set Styles
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
    
    self.ThisTimeClearButton.hidden = YES;
    self.NextTimeClearButton.hidden = YES;
    self.ThisTimePlaceholder.hidden = YES;
    self.NextTimePlaceholder.hidden = YES;
    
    [self showPlaceholderIfEmpty];
    
}

- (void) activityNameSelected {
    self.activityName.textAlignment = NSTextAlignmentLeft;
}

- (void) activityNameDeSelected {
    self.activityName.textAlignment = NSTextAlignmentCenter;
}

- (void) textViewDidBeginEditing:(UITextView *)textView {
    // Show correct clear button
    if (textView == self.itemNote) {
        self.ThisTimePlaceholder.hidden = YES;
        self.ThisTimeClearButton.hidden = NO;
    } else if (textView == self.futureItemNote) {
        self.NextTimePlaceholder.hidden = YES;
        self.NextTimeClearButton.hidden = NO;
    }
}

- (void) showPlaceholderIfEmpty {
    if ([self.itemNote.text isEqual:@""] || self.itemNote.text == nil) {
        self.ThisTimePlaceholder.hidden = NO;
    }
    if ([self.futureItemNote.text isEqual:@""] || self.futureItemNote.text == nil) {
        self.NextTimePlaceholder.hidden = NO;
    }
}

- (void) textViewDidEndEditing:(UITextView *)textView {
    // hide clear buttons and placeholders when done editing
    
    self.ThisTimeClearButton.hidden = YES;
    self.NextTimeClearButton.hidden = YES;
    
    [self showPlaceholderIfEmpty];

}

- (void) clearThisTime {
    self.itemNote.text = @"";
}

- (void)dismissKeyboard {
    [self.view endEditing:YES];
}

- (IBAction)save:(id)sender {
    loadedItem.thisTimeNote = self.itemNote.text;
    loadedItem.itemName = self.activityName.text;
    loadedItem.nextTimeNote = self.futureItemNote.text;
    loadedItem.lastUpdate = [NSDateFormatter localizedStringFromDate:[NSDate date] dateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterShortStyle];
    
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
    [self showPlaceholderIfEmpty];
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
