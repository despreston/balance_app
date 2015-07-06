//
//  EditorViewController.m
//  Balance
//
//  Created by Desmond Preston on 6/5/15.
//  Copyright (c) 2015 Desmond Preston. All rights reserved.
//

#import "EditorViewController.h"

@interface EditorViewController ()
@property (nonatomic, strong) JFMinimalNotification* itemNoteMessage;

@end

@implementation EditorViewController
@synthesize note;
@synthesize noteToEdit;
@synthesize editorDelegate;
@synthesize editNote;
@synthesize itemNoteMessage;

- (void)viewDidLoad {
    [super viewDidLoad];
    note.delegate = self;
    note.text = editNote;
    [[UINavigationBar appearanceWhenContainedIn:[EditorViewController class], nil] setBarTintColor:[UIColor whiteColor]];
    
    // set focus to text view
    [self.note becomeFirstResponder];
    
    self.itemNoteMessage = [JFMinimalNotification notificationWithStyle:JFMinimalNotificationStyleDefault title:@"Nice!" subTitle:@"What did you get done this time?"];
    
    //[self.view addSubview:self.itemNoteMessage];
    //[self.itemNoteMessage show];
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

- (void)dealloc {
    self.itemNoteMessage = nil;
}

@end
