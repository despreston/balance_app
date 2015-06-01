//
//  AddNoteViewController.m
//  ToDoList
//
//  Created by Desmond Preston on 2/16/15.
//  Copyright (c) 2015 Desmond Preston. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "AddNoteViewController.h"
#import <CoreData/CoreData.h>

@interface AddNoteViewController ()
@end

@implementation AddNoteViewController
@synthesize item;


- (NSManagedObjectContext *)managedObjectContext {
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    return context;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (self.item) {
        [self.activityName setText:[self.item valueForKey:@"name"]];
        [self.itemNote setText:[self.item valueForKey:@"thisTimeNote"]];
        [self.futureItemNote setText:[self.item valueForKey:@"nextTimeNote"]];
    }
    
    self.itemNote.delegate = self;
    self.futureItemNote.delegate = self;
    
    UITapGestureRecognizer *thisTimeClearButtonTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clearThisTime)];
    [self.ThisTimeClearButton addGestureRecognizer:thisTimeClearButtonTap];
    
    // Activity name notification
    [self.activityName addTarget:self action:@selector(activityNameSelected)forControlEvents:UIControlEventEditingDidBegin];
    [self.activityName addTarget:self action:@selector(activityNameDeSelected)forControlEvents:UIControlEventEditingDidEnd];
    
    // hide keyboard when clicking outside of textview
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];
    
    // Set Styles
    self.activityName.font = [UIFont fontWithName:@"HelveticaNeue-Medium" size: 18];
    self.ThisTimeLabel.font = [UIFont fontWithName:@"HelveticaNeue-Medium" size: 18];
    self.NextTimeLabel.font = [UIFont fontWithName:@"HelveticaNeue-Medium" size: 18];
    
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
    self.ThisTimePlaceholder.hidden = YES;
    self.NextTimePlaceholder.hidden = YES;
    
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

- (IBAction)cancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)dismissKeyboard {
    [self.view endEditing:YES];
}

- (IBAction)save:(id)sender {
    NSManagedObjectContext *context = [self managedObjectContext];
    
    // Edit existing item
    if (self.item) {
        [self.item setValue:self.activityName.text forKey:@"name"];
        [self.item setValue:self.itemNote.text forKey:@"thisTimeNote"];
        [self.item setValue:self.futureItemNote.text forKey:@"nextTimeNote"];
        [self.item setValue:[NSDateFormatter localizedStringFromDate:[NSDate date] dateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterShortStyle] forKey:@"lastUpdate"];

    } else {
        // Create a new item
        NSManagedObject *newItem = [NSEntityDescription insertNewObjectForEntityForName:@"Item" inManagedObjectContext:context];
        [newItem setValue:[NSDateFormatter localizedStringFromDate:[NSDate date] dateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterShortStyle] forKey:@"lastUpdate"];
        [newItem setValue:self.activityName.text forKey:@"name"];
        [newItem setValue:self.futureItemNote.text forKey:@"nextTimeNote"];
        [newItem setValue:self.itemNote.text forKey:@"thisTimeNote"];
    }
    
    NSError *error = nil;
    // Save the object to persistent store
    if (![context save:&error]) {
        NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
    }
    
    [self.navigationController popViewControllerAnimated:YES];
    
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
            self.SaveButton.enabled = YES;
       // }
    } else {
        self.SaveButton.enabled = NO;
    }
}

@end
