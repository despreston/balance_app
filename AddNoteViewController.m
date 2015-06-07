//
//  AddNoteViewController.m
//  ToDoList
//
//  Created by Desmond Preston on 2/16/15.
//  Copyright (c) 2015 Desmond Preston. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "AddNoteViewController.h"
#import "EditorViewController.h"
#import <CoreData/CoreData.h>

@interface AddNoteViewController()
@end

@implementation AddNoteViewController
@synthesize item;
@synthesize itemNote;
@synthesize futureItemNote;


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
        [self.itemNote setTextColor:[UIColor darkGrayColor]];
        [self.futureItemNote setTextColor:[UIColor darkGrayColor]];
    } else {
        [self.activityName becomeFirstResponder];
    }
    
    // Create and style the 2 main buttons at the top
    [self createNoteButtons];
    
    // Activity name notification
    [self.activityName addTarget:self action:@selector(activityNameSelected)forControlEvents:UIControlEventEditingDidBegin];
    [self.activityName addTarget:self action:@selector(activityNameDeSelected)forControlEvents:UIControlEventEditingDidEnd];
    
    // hide keyboard when clicking outside of textview
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];
    
    [self showPlaceholderIfEmpty];
}

- (void) createNoteButtons {
    // This Time note
    CGRect addThisTimeNoteFrame = self.addThisTimeNote.frame;
    addThisTimeNoteFrame.size = CGSizeMake(160, 55);
    self.addThisTimeNote.frame = addThisTimeNoteFrame;
    [self.addThisTimeNote setTitle:@"I Did Work" forState:UIControlStateNormal];
    self.addThisTimeNote.center = CGPointMake(85,75);
    [self.addThisTimeNote setBackgroundColor:[UIColor colorWithRed:46.0f/255.0f green:148.0f/255.0f blue:227.0f/255.0f alpha:1.0]];
    [self.addThisTimeNote setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.addThisTimeNote.layer.cornerRadius = 3;
    
    // Next Time note
    CGRect addNextTimeNoteFrame = self.addNextTimeNote.frame;
    addNextTimeNoteFrame.size = CGSizeMake(160, 55);
    self.addNextTimeNote.frame = addThisTimeNoteFrame;
    [self.addNextTimeNote setTitle:@"Note to Remember" forState:UIControlStateNormal];
    self.addNextTimeNote.center = CGPointMake(185,75);
    [self.addNextTimeNote setBackgroundColor:[UIColor colorWithRed:46.0f/255.0f green:148.0f/255.0f blue:227.0f/255.0f alpha:1.0]];
    [self.addNextTimeNote setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.addNextTimeNote.layer.cornerRadius = 3;

}

- (void) activityNameSelected {
    self.activityName.textAlignment = NSTextAlignmentLeft;
}

- (void) activityNameDeSelected {
    self.activityName.textAlignment = NSTextAlignmentCenter;
}

- (void) showPlaceholderIfEmpty {
    if ([self.itemNote.text isEqual:@""] || self.itemNote.text == nil) {
        self.itemNote.text = @"Tap 'I Did Work' to add what you last did.";
        [self.itemNote setTextColor:[UIColor lightGrayColor]];
    }
    if ([self.futureItemNote.text isEqual:@""] || self.futureItemNote.text == nil) {
        self.futureItemNote.text = @"Tap 'Note to Remember' to leave a note for next time.";
        [self.futureItemNote setTextColor:[UIColor lightGrayColor]];
    }
}

- (IBAction)cancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)dismissKeyboard {
    [self.view endEditing:YES];
}

- (IBAction)editNoteButtonPressed:(id)sender {
    [self performSegueWithIdentifier:@"editNote" sender:sender];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    UIButton *pressedButton = (UIButton *)sender;
    EditorViewController *destViewController = segue.destinationViewController;
    
    if ([pressedButton.titleLabel.text isEqualToString:self.addThisTimeNote.titleLabel.text]) {
        destViewController.passedNote = self.itemNote.text;
    } else if ([pressedButton.titleLabel.text isEqualToString:self.addNextTimeNote.titleLabel.text]) {
        destViewController.passedNote = self.futureItemNote.text;
    }
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
