//
//  EditorViewController.m
//  Balance
//
//  Created by Desmond Preston on 6/5/15.
//  Copyright (c) 2015 Desmond Preston. All rights reserved.
//

#import "EditorViewController.h"

#define DIDWORKPOPUPMESSAGE "Nice! What did you finish this time?"
#define TODOPOPUPMESSAGE "Leave a note that will help you get started quickly next time."

@interface EditorViewController ()
@property (nonatomic, strong) SJNotificationViewController* messageController;

@end

@implementation EditorViewController
@synthesize note;
@synthesize noteToEdit;
@synthesize editorDelegate;
@synthesize editNote;
@synthesize messageController;
@synthesize note_bottom;

- (void)viewDidLoad {
    [super viewDidLoad];
    note.delegate = self;
    note.text = editNote;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardFrameWillChange:) name:UIKeyboardWillChangeFrameNotification object:nil];

    [[UINavigationBar appearanceWhenContainedIn:[EditorViewController class], nil] setBarTintColor:[UIColor whiteColor]];
    
    // set focus to text view
    [self.note becomeFirstResponder];
    
    if ([self.note.text isEqualToString:@""]) {
        self.messageController = [[SJNotificationViewController alloc] initWithNibName:@"SJNotificationViewController" bundle:nil];
        [self.messageController setParentView:self.note];
        if ([self.noteToEdit isEqual:@"thisTimeNote"]) {
            [self.messageController setNumberOfLines:1];
            [self.messageController setNotificationTitle:@DIDWORKPOPUPMESSAGE];
        } else if ([self.noteToEdit isEqual:@"nextTimeNote"]) {
            [self.messageController setNumberOfLines:2];
            [self.messageController setNotificationTitle:@TODOPOPUPMESSAGE];
        }
    }
}

- (void)keyboardFrameWillChange:(NSNotification *)notification {
    /*keyboard sizes change so need to set the textfield's constraint after keyboard has loaded */
    CGFloat height = [[notification.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;
    
    self.note_bottom.constant = height;
    [self.view layoutIfNeeded];
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
