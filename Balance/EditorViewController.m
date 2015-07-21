//
//  EditorViewController.m
//  Balance
//
//  Created by Desmond Preston on 6/5/15.
//  Copyright (c) 2015 Desmond Preston. All rights reserved.
//

#import "EditorViewController.h"

@interface EditorViewController ()
@property (nonatomic, strong) SJNotificationViewController* messageController;

@end

@implementation EditorViewController
@synthesize note;
@synthesize noteToEdit;
@synthesize editorDelegate;
@synthesize editNote;
@synthesize messageController;

- (void)viewDidLoad {
    [super viewDidLoad];
    note.delegate = self;
    note.text = editNote;
    [[UINavigationBar appearanceWhenContainedIn:[EditorViewController class], nil] setBarTintColor:[UIColor whiteColor]];
    
    // set focus to text view
    [self.note becomeFirstResponder];
    
    if ([self.note.text isEqualToString:@""]) {
        self.messageController = [[SJNotificationViewController alloc] initWithNibName:@"SJNotificationViewController" bundle:nil];
        [self.messageController setParentView:self.note];
        if ([self.noteToEdit isEqual:@"thisTimeNote"]) {
            [self.messageController setNumberOfLines:1];
            [self.messageController setNotificationTitle:@"Nice! What did you finish this time?"];
        } else if ([self.noteToEdit isEqual:@"nextTimeNote"]) {
            [self.messageController setNumberOfLines:2];
            [self.messageController setNotificationTitle:@"Leave a note that will help you get started quickly next time."];
        }
    }
}

- (void)viewDidAppear:(BOOL)animated {
    [self.messageController show];
}

-(BOOL)prefersStatusBarHidden{
    return YES;
}

- (void)textViewDidChange:(UITextView *)textView {
    [self.messageController hide];
    if (![self.note.text isEqualToString:@""]) {
        self.Done.enabled = YES;
    } else {
        self.Done.enabled = NO;
    }
}

- (IBAction)Done:(id)sender {
    [self.editorDelegate modifyItemFromEditor:self.note.text forNote:self.noteToEdit];
    [self.view endEditing:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)ClearButtonPressed:(id)sender {
    [self.note setText:@""];
    self.Done.enabled = YES;
}

- (IBAction)Back:(id)sender{
    [self.view endEditing:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)dealloc {
    self.messageController = nil;
}

@end
