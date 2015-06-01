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
    
    // Fetch the devices from persistent data store
    NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Item"];
    self.items = [[managedObjectContext executeFetchRequest:fetchRequest error:nil] mutableCopy];
    
    [self.tableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // set the back button to be blank
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    
    // register the custom cell
    [self.tableView registerNib:[UINib nibWithNibName:@"CustomCell" bundle:nil] forCellReuseIdentifier:@"ToDoItemCell"];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

- (IBAction)unwindToMainMenu:(UIStoryboardSegue*)sender
{
        [self.tableView reloadData];
}

- (CustomCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"ToDoItemCell";
    CustomCell *cell = (CustomCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    NSManagedObject *item = [self.items objectAtIndex:indexPath.row];
    
    // set texts
    [cell.name setText:[NSString stringWithFormat:@"%@", [item valueForKey:@"name"]]];
    [cell.lastText setText:[NSString stringWithFormat:@"%@", [item valueForKey:@"thisTimeNote"]]];
    [cell.nextText setText:[NSString stringWithFormat:@"%@", [item valueForKey:@"nextTimeNote"]]];
    [cell.lastUpdatedText setText:[NSString stringWithFormat:@"Last Updated: %@", [item valueForKey:@"lastUpdate"]]];
    
    // Cell View
    UIView *cellView = [[UIView alloc]initWithFrame:CGRectMake(0,0, cell.frame.size.width, cell.frame.size.height)];
    // View for all content in each cell
    UIView *cellContent = [[UIView alloc]initWithFrame:CGRectMake(5,10, cellView.frame.size.width-10, cellView.frame.size.height-15)];
    cellContent.layer.borderWidth = 1.0f;
    cellContent.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    cellContent.layer.cornerRadius = 5;

    [cellView addSubview:cellContent];
    [cell.contentView addSubview:cellView];
    
    [cell.lastText setNumberOfLines:0];
    [cell.lastText sizeToFit];
    
    if (cell == nil) {
        cell = [[CustomCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self performSegueWithIdentifier:@"showItemNote" sender:nil];
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
