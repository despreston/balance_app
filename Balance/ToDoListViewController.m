//
//  ToDoListViewController.m
//  Balance
//
//  Created by Desmond Preston on 2/16/15.
//  Copyright (c) 2015 Desmond Preston. All rights reserved.
//

#import "ToDoListViewController.h"
#import "ToDoItem.h"
#import "AddNoteViewController.h"
#import <Foundation/Foundation.h>

@interface ToDoListViewController ()

@end

@implementation ToDoListViewController {
    NSMutableArray *toDoItems;
}

@synthesize tableView = _tableView;

- (void)loadInitialData {
    ToDoItem *item1 = [[ToDoItem alloc] init];
    item1.itemName = @"Buy Milk";
    item1.note = @"Testing the note for this buy milk item!";
    [toDoItems addObject:item1];
    
    ToDoItem *item2 = [[ToDoItem alloc] init];
    item2.itemName = @"Do Homework";
    item2.note = @"Homework note";
    [toDoItems addObject:item2];
    
    ToDoItem *item3 = [[ToDoItem alloc] init];
    item3.itemName = @"Read textbook";
    item3.note = @"Textbook note ";
    [toDoItems addObject:item3];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    toDoItems = [ [NSMutableArray alloc] init];
    [self loadInitialData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [toDoItems count];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"showItemNote"]) {
        //NSLog(@"%@", [self.tableView indexPathForSelectedRow]);
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        AddNoteViewController *destViewController = segue.destinationViewController;
        destViewController.toDoItem = [toDoItems objectAtIndex:[indexPath row]];
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    static NSString *simpleTableIdentifier = @"ToDoItemCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    
    //UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ListPrototypeCell" forIndexPath:indexPath];
    
    ToDoItem *toDoItem = [toDoItems objectAtIndex: indexPath.row];
    cell.textLabel.text = toDoItem.itemName;
    
    return cell;
}


- (void)tableView:(UITableView *)tableView
commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        //add code here to do what you want when you hit delete
        [toDoItems removeObjectAtIndex:[indexPath row]];
        [tableView reloadData];
    }
}

@end
