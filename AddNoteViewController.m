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

- (void)modifyItemFromEditor:(NSString *)editedNote forNote:(NSString *)noteToEdit {
    NSLog(@"%@ TO EDIT: %@", editedNote, noteToEdit);
    if ([noteToEdit isEqual:@"thisTimeNote"]) {
        self.itemNote.text = editedNote;
    } else if ([noteToEdit isEqual:@"nextTimeNote"]) {
        self.futureItemNote.text = editedNote;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Create and style the 2 main buttons at the top
    [self createNoteButtons];
    
    self.activityName.delegate = self;
    
    if (self.item) {
        [self toggleButtonsEnabled:YES];
        [self loadData];
        CGRect temp = self.activityName.frame;
        temp.size.height = CGFLOAT_MAX;
        self.activityName.frame = temp;
        [self.activityName sizeToFit];
    } else {
        [self toggleButtonsEnabled:NO];
        [self.activityName becomeFirstResponder];
    }
    
    // hide keyboard when clicking outside of textview
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];
}

- (void)viewWillAppear:(BOOL)animated {
    [self showPlaceholderIfEmpty];
}

- (void)loadData {
    [self.activityName setText:[self.item valueForKey:@"name"]];
    [self.itemNote setText:[self.item valueForKey:@"thisTimeNote"]];
    [self.futureItemNote setText:[self.item valueForKey:@"nextTimeNote"]];
}

- (void) createNoteButtons {
    //UIColor *buttonColor = [UIColor colorWithRed:46.0f/255.0f green:148.0f/255.0f blue:227.0f/255.0f alpha:1.0];
    UIColor *borderColor = [UIColor colorWithRed:215.0f/255.0f green:215.0f/255.0f blue:215.0f/255.0f alpha:1.0];
    NSString *thisTimeNoteText = @"I Did Work";
    NSString *nextTimeNoteText = @"To Do Next";
    
    // This Time note
    CGRect addThisTimeNoteFrame = self.addThisTimeNote.frame;
    addThisTimeNoteFrame.size = CGSizeMake(160, 55);
    self.addThisTimeNote.frame = addThisTimeNoteFrame;
    [self.addThisTimeNote setTitle:thisTimeNoteText forState:UIControlStateNormal];
    self.addThisTimeNote.center = CGPointMake(85,75);
    //[self.addThisTimeNote setBackgroundColor:buttonColor];
    [self.addThisTimeNote setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.addThisTimeNote.layer.cornerRadius = 3;
    self.addThisTimeNote.layer.shadowColor = borderColor.CGColor;
    self.addThisTimeNote.layer.shadowOffset = CGSizeMake(0, 1.2);
    self.addThisTimeNote.layer.shadowOpacity = 1.0;
    self.addThisTimeNote.layer.shadowRadius = 0.0;
    
    // Next Time note
    CGRect addNextTimeNoteFrame = self.addNextTimeNote.frame;
    addNextTimeNoteFrame.size = CGSizeMake(160, 55);
    self.addNextTimeNote.frame = addThisTimeNoteFrame;
    [self.addNextTimeNote setTitle:nextTimeNoteText forState:UIControlStateNormal];
    self.addNextTimeNote.center = CGPointMake(185,75);
    //[self.addNextTimeNote setBackgroundColor:buttonColor];
    [self.addNextTimeNote setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.addNextTimeNote.layer.cornerRadius = 3;
    self.addNextTimeNote.layer.shadowColor = borderColor.CGColor;
    self.addNextTimeNote.layer.shadowOffset = CGSizeMake(0, 1.2);
    self.addNextTimeNote.layer.shadowOpacity = 1.0;
    self.addNextTimeNote.layer.shadowRadius = 0.0;
}

- (void) toggleButtonsEnabled:(BOOL)enabled {
    UIColor *buttonColor = [UIColor colorWithRed:46.0f/255.0f green:148.0f/255.0f blue:227.0f/255.0f alpha:1.0];
    UIColor *disabledButtonColor = [UIColor colorWithRed:46.0f/255.0f green:148.0f/255.0f blue:227.0f/255.0f alpha:0.4];
    
    if (enabled == YES) {
        [self.addNextTimeNote setEnabled:YES];
        [self.addThisTimeNote setEnabled:YES];
        [self.addThisTimeNote setBackgroundColor:buttonColor];
        [self.addNextTimeNote setBackgroundColor:buttonColor];
    } else {
        [self.addNextTimeNote setEnabled:NO];
        [self.addThisTimeNote setEnabled:NO];
        [self.addThisTimeNote setBackgroundColor:disabledButtonColor];
        [self.addNextTimeNote setBackgroundColor:disabledButtonColor];
    }
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    self.activityName.textAlignment = NSTextAlignmentLeft;
    //CGAffineTransform slide = CGAffineTransformMakeTranslation(-50.0f, 0.0f);
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.2];
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
    [self.activityName setFrame:CGRectMake(10.0f, 75.0f, 100.0f, 42.0f)];
    [UIView commitAnimations];
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.2];
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
    [self.activityName setFrame:CGRectMake(10.0f, 75.0f, 300.0f, 42.0f)];
    [UIView commitAnimations];
    
    [self toggleButtonsEnabled:NO];
    
    return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    self.activityName.textAlignment = NSTextAlignmentCenter;
    [self.activityName sizeToFit];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.2];
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
    [self.activityName setFrame:CGRectMake(95.0f, 75.0f, self.activityName.bounds.size.width, 42.0f)];
    [UIView commitAnimations];
    if ([self activityNameChanged]) {
        [self toggleButtonsEnabled:YES];
    } else {
        [self toggleButtonsEnabled:NO];
    }
    
    return YES;
}

- (void) showPlaceholderIfEmpty {
    NSString *itemNotePlaceholder = @"Tap 'I Did Work' to add what you finished.";
    NSString *futureItemNotePlaceholder = @"Tap 'To Do Next' to leave a new note for the future.";
    
    if ([self.itemNote.text isEqual:@""] || self.itemNote.text == nil || [self.itemNote.text isEqual:itemNotePlaceholder]) {
        self.itemNote.text = itemNotePlaceholder;
        [self.itemNote setTextColor:[UIColor lightGrayColor]];
    } else {
        [self.itemNote setTextColor:[UIColor darkGrayColor]];
    }
    if ([self.futureItemNote.text isEqual:@""] || self.futureItemNote.text == nil || [self.futureItemNote.text isEqual:futureItemNotePlaceholder]) {
        self.futureItemNote.text = futureItemNotePlaceholder;
        [self.futureItemNote setTextColor:[UIColor lightGrayColor]];
    } else {
        [self.futureItemNote setTextColor:[UIColor darkGrayColor]];
    }
}

- (void)dismissKeyboard {
    [self.view endEditing:YES];
}

- (IBAction)createNoteButtonPressed:(id)sender {
    [self performSegueWithIdentifier:@"createNote" sender:sender];
}

- (IBAction)createBottomMenu:(id)sender {
    UIButton *pressedButton = (UIButton *)sender;
    
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Note Options" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction* editNote = [UIAlertAction actionWithTitle:@"Edit Note" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
            [self performSegueWithIdentifier:@"editNote" sender:pressedButton];
    }];
    UIAlertAction* clearNote = [UIAlertAction actionWithTitle:@"Clear" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {}];
    UIAlertAction* Cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * action) {}];
    
    [alert addAction:editNote];
    [alert addAction:clearNote];
    [alert addAction:Cancel];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    UIButton *pressedButton = (UIButton *)sender;
    EditorViewController *destViewController = segue.destinationViewController;
    
    if ([pressedButton.titleLabel.text isEqualToString:self.addThisTimeNote.titleLabel.text]) {
        destViewController.noteToEdit = @"thisTimeNote";
        if ([segue.identifier isEqualToString:@"editNote"] && ![self.itemNote.text isEqualToString:@"Tap 'I Did Work' to add what you finished."]) {
            destViewController.editNote = self.itemNote.text;
        }
    } else if ([pressedButton.titleLabel.text isEqualToString:self.addNextTimeNote.titleLabel.text]) {
        if ([segue.identifier isEqualToString:@"editNote"] && ![self.futureItemNote.text isEqualToString:@"Tap 'To Do Next' to leave a new note for the future."]) {
            destViewController.note.text = self.futureItemNote.text;
        }
        destViewController.noteToEdit = @"nextTimeNote";
    }
    
    destViewController.editorDelegate = self;
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
    // Check for dirty activity name
    if ([self activityNameChanged] == YES) {
        // If VC count is >1 it means we are entering editor. Dont save yet!
        // ugly. but works. I'm not pushing/popping controllers so this is how I can tell I am moving to main VC
        NSArray *viewControllers = self.navigationController.viewControllers;
        if (!self.item && viewControllers.count == 1) {
            NSManagedObjectContext *context = [self managedObjectContext];
            NSManagedObject *newItem = [NSEntityDescription insertNewObjectForEntityForName:@"Item" inManagedObjectContext: context];
            [newItem setValue:self.activityName.text forKey:@"name"];
            if ([self.itemNote.text isEqual:@"Tap 'I Did Work' to add what you finished."]) {
                [newItem setValue:@"" forKey:@"thisTimeNote"];
            } else {
                [newItem setValue:self.itemNote.text forKey:@"thisTimeNote"];
            }
            if ([self.futureItemNote.text isEqual:@"Tap 'To Do Next' to leave a new note for the future."]) {
                [newItem setValue:@"" forKey:@"nextTimeNote"];
            } else {
                [newItem setValue:self.futureItemNote.text forKey:@"nextTimeNote"];
            }
            [newItem setValue:[NSDateFormatter localizedStringFromDate:[NSDate date] dateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterShortStyle] forKey:@"lastUpdate"];
            NSError *error = nil;
            // Save the object to persistent store
            if (![context save:&error]) {
                NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
            }
        } else {
            [self.item setValue:self.activityName.text forKey:@"name"];
            if (![self.itemNote.text isEqual:@"Tap 'I Did Work' to add what you finished."]) {
                [self.item setValue:self.itemNote.text forKey:@"thisTimeNote"];
            }
            if (![self.futureItemNote.text isEqual:@"Tap 'To Do Next' to leave a new note for the future."]) {
                [self.item setValue:self.futureItemNote.text forKey:@"nextTimeNote"];
            }
        }
    }
}
@end
