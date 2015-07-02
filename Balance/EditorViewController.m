//
//  EditorViewController.m
//  Balance
//
//  Created by Desmond Preston on 6/5/15.
//  Copyright (c) 2015 Desmond Preston. All rights reserved.
//

#import "EditorViewController.h"

@interface EditorViewController ()

@end

@implementation EditorViewController
@synthesize note;
@synthesize noteToEdit;
@synthesize editorDelegate;
@synthesize editNote;

- (void)viewDidLoad {
    [super viewDidLoad];
    note.delegate = self;
    note.text = editNote;
    [[UINavigationBar appearanceWhenContainedIn:[EditorViewController class], nil] setBarTintColor:[UIColor whiteColor]];
    
    // set focus to text view
    [self.note becomeFirstResponder];
}

-(BOOL)prefersStatusBarHidden{
    return YES;
}

- (void)textViewDidChange:(UITextView *)textView {
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

@end
