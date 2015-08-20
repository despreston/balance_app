//
//  ToDoListViewController.m
//  Balance
//
//  Created by Desmond Preston on 2/16/15.
//  Copyright (c) 2015 Desmond Preston. All rights reserved.
//

#import "ToDoListViewController.h"
#import "AddNoteViewController.h"
#import "CustomCell.h"
#import "guide.h"
#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface ToDoListViewController ()
@property (strong) NSMutableArray *items;
@end

@implementation ToDoListViewController

@synthesize tableView = _tableView;

- (NSManagedObjectContext *)managedObjectContext
{
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    return context;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Item"];
   // NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"createdDate" ascending:YES];
    self.items = [[managedObjectContext executeFetchRequest:fetchRequest error:nil] mutableCopy];
    
    [self.tableView reloadData];
    BOOL newUser = YES;
    
    if (newUser) {
        guide *newUserGuide = [[guide alloc]initWithNibName:@"guide" bundle:nil];
        newUserGuide.modalPresentationStyle = UIModalPresentationOverCurrentContext;
        [self presentViewController:newUserGuide animated:YES completion:nil];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // set back button text
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:nil action:nil];
    
    // register the custom cell
    [self.tableView registerNib:[UINib nibWithNibName:@"CustomCell" bundle:nil] forCellReuseIdentifier:@"ToDoItemCell"];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showItemNote"]) {
        NSManagedObject *selectedItem = [self.items objectAtIndex:[[self.tableView indexPathForSelectedRow] row]];
        AddNoteViewController *destViewController = segue.destinationViewController;
        destViewController.item = selectedItem;
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.items count];
}

- (CustomCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"ToDoItemCell";
    CustomCell *cell = (CustomCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    NSManagedObject *item = [self.items objectAtIndex:indexPath.row];
    
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    // set texts
    [cell.name setText:[NSString stringWithFormat:@"%@", [item valueForKey:@"name"]]];
    [cell.lastText setText:[NSString stringWithFormat:@"%@", [item valueForKey:@"thisTimeNote"]]];
    [cell.nextText setText:[NSString stringWithFormat:@"%@", [item valueForKey:@"nextTimeNote"]]];
    
    NSString *lastUpdated = [NSDateFormatter localizedStringFromDate:[item valueForKey:@"lastUpdate"] dateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterShortStyle];
    [cell.lastUpdatedText setText:[NSString stringWithFormat:@"Last Update: %@", lastUpdated]];
    
    [cell.lastText sizeToFit];
    [cell.nextText sizeToFit];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(CustomCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    NSManagedObject *item = [self.items objectAtIndex:indexPath.row];
    UIColor *color = [self getStatusColor:[item valueForKey:@"lastUpdate"]];
    [cell.update_status setBackgroundColor:color];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self performSegueWithIdentifier:@"showItemNote" sender:nil];
}

- (UIColor *)getStatusColor:(NSDate *)lastUpdate {
    NSDateFormatter *dateFormatter =[[NSDateFormatter alloc] init];
    NSDateComponents *components;
    NSInteger days;
    
    /* Calculate diff in days between now and last updated date */
    [dateFormatter setDateStyle:NSDateFormatterShortStyle];
    components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay fromDate:lastUpdate toDate:[[NSDate alloc]init] options:0];
    days = [components day];
    
    if (days < 1) {
        /* light green */
        return [UIColor colorWithRed:140.0f/255.0f green:191.0f/255.0f blue:81.0f/255.0f alpha:65.0f];
    } else if (days >= 1 && days < 7) {
        /* white */
        return [UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:65.0f];
    } else if (days >= 7 && days < 14) {
        /* light orange */
        return [UIColor colorWithRed:255.0f/255.0f green:178.0f/255.0f blue:102.0f/255.0f alpha:65.0f];
    } else {
        /* light red */
        return [UIColor colorWithRed:255.0f/255.0f green:114.0f/255.0f blue:114.0f/255.0f alpha:65.0f];
    }
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSManagedObjectContext *context = [self managedObjectContext];
    
    [self.tableView beginUpdates];
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete object from database
        [context deleteObject:[self.items objectAtIndex:indexPath.row]];
        
        NSError *error = nil;
        if (![context save:&error]) {
            NSLog(@"Can't Delete! %@ %@", error, [error localizedDescription]);
            return;
        }
        
        // Remove item from table view
        [self.items removeObjectAtIndex:indexPath.row];
        [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
    [self.tableView endUpdates];
}

- (void)AddItem:(id)sender {
    [self performSegueWithIdentifier:@"createNewItem" sender:self];
}

@end
