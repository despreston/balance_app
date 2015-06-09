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
        [self loadData];
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

- (void)viewWillAppear:(BOOL)animated {
    [self loadData];
    [self showPlaceholderIfEmpty];
}

- (void)loadData {
    [self.activityName setText:[self.item valueForKey:@"name"]];
    [self.itemNote setText:[self.item valueForKey:@"thisTimeNote"]];
    [self.futureItemNote setText:[self.item valueForKey:@"nextTimeNote"]];
    [self.itemNote setTextColor:[UIColor darkGrayColor]];
    [self.futureItemNote setTextColor:[UIColor darkGrayColor]];
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
    [self.addNextTimeNote setTitle:@"Note for Future" forState:UIControlStateNormal];
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
        self.futureItemNote.text = @"Tap 'Note for Future' to leave a note for next time.";
        [self.futureItemNote setTextColor:[UIColor lightGrayColor]];
    }
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
        destViewController.noteToEdit = @"thisTimeNote";
    } else if ([pressedButton.titleLabel.text isEqualToString:self.addNextTimeNote.titleLabel.text]) {
        destViewController.noteToEdit = @"nextTimeNote";
    }
    
    destViewController.item = self.item;
}

- (BOOL)activityNameChanged {
    if (![self.activityName.text isEqual:@""]) {
        return YES;
    } else {
        return NO;
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    if ([self activityNameChanged] == YES) {
        [self.item setValue:self.activityName.text forKey:@"name"];
        if (!self.item) {
            NSManagedObjectContext *context = [self managedObjectContext];
            NSManagedObject *newItem = [NSEntityDescription insertNewObjectForEntityForName:@"Item" inManagedObjectContext: context];
            [newItem setValue:self.activityName.text forKey:@"name"];
            [newItem setValue:@"" forKey:@"thisTimeNote"];
            [newItem setValue:@"" forKey:@"nextTimeNote"];
            [newItem setValue:[NSDateFormatter localizedStringFromDate:[NSDate date] dateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterShortStyle] forKey:@"lastUpdate"];
        }
    }
}

@end
