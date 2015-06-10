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
    
    note.delegate = self;

    [[UINavigationBar appearanceWhenContainedIn:[EditorViewController class], nil] setBarTintColor:[UIColor whiteColor]];
    
    if (self.item) {
        NSString *noteText = [self.item valueForKey:self.noteToEdit];
        [self.note setText:noteText];
    }
    
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
    NSManagedObjectContext *context = [self managedObjectContext];
    
    // Edit existing item
    if (self.item) {
        [self.item setValue:self.note.text forKey:self.noteToEdit];
        [self.item setValue:[NSDateFormatter localizedStringFromDate:[NSDate date] dateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterShortStyle] forKey:@"lastUpdate"];
        
    } else {
        // Create a new item
        NSManagedObject *newItem = [NSEntityDescription insertNewObjectForEntityForName:@"Item" inManagedObjectContext:context];
        [newItem setValue:[NSDateFormatter localizedStringFromDate:[NSDate date] dateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterShortStyle] forKey:@"lastUpdate"];
        [newItem setValue:self.note.text forKey:self.noteToEdit];
    }
    
    NSError *error = nil;
    // Save the object to persistent store
    if (![context save:&error]) {
        NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
    }
    
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
