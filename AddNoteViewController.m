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
    NSObject *activeField;
}

@synthesize itemNote;
@synthesize futureItemNote;
@synthesize ScrollView;

- (void)viewDidLoad {
    [super viewDidLoad];
    sharedManager = [BAModel sharedManager];
    
    loadedItem = [[sharedManager toDoItems] objectAtIndex:[[sharedManager activeItem] row]];
    
    // hide keyboard when clicking outside of textview
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];
    
    // Move the view if the keyboard is blocking the text field
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillChangeFrameNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
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
    [[sharedManager toDoItems] replaceObjectAtIndex:[[sharedManager activeItem] row] withObject:loadedItem];
    [self performSegueWithIdentifier:@"unwindToMainMenu" sender:self];
}


- (void)keyboardWillShow:(NSNotification *)notification
{
    NSDictionary *info = [notification userInfo];
    NSValue *kbFrame = [info objectForKey:UIKeyboardFrameEndUserInfoKey];
    NSTimeInterval animationDuration = [[info objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    CGRect keyboardFrame = [kbFrame CGRectValue];
    
    self.keyboardHeight.constant = keyboardFrame.size.height;
    
    [UIView animateWithDuration:animationDuration animations:^{
        [self.view layoutIfNeeded];
    }];
}

- (void)keyboardWillHide:(NSNotification *)notification
{
    NSDictionary *info = [notification userInfo];
    NSTimeInterval animationDuration = [[info objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    self.keyboardHeight.constant = 20;
    [UIView animateWithDuration:animationDuration animations:^{
        [self.view layoutIfNeeded];
    }];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    activeField = textField;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    activeField = nil;
}


@end
