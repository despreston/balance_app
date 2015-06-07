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
@synthesize passedNote;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    note.delegate = self;

    [[UINavigationBar appearanceWhenContainedIn:[EditorViewController class], nil] setBarTintColor:[UIColor whiteColor]];
    
    [self.note setText:passedNote];
    
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

- (IBAction)ClearButtonPressed:(id)sender {
    [self.note setText:@""];
}

- (IBAction)Back:(id)sender{
    [[self presentingViewController] dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)Done:(id)sender {
    [[self presentingViewController] dismissViewControllerAnimated:YES completion:nil];
}

@end
