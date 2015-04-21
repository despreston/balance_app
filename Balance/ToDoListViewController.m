//
//  ToDoListViewController.m
//  Balance
//
//  Created by Desmond Preston on 2/16/15.
//  Copyright (c) 2015 Desmond Preston. All rights reserved.
//

#import "ToDoListViewController.h"
#import "BAModel.h"
#import "BAItem.h"
#import "AddNoteViewController.h"
#import <Foundation/Foundation.h>

@interface ToDoListViewController ()

@end

@implementation ToDoListViewController {
    BAModel *sharedManager;
}

@synthesize tableView = _tableView;

- (void)loadInitialData {
    
    BAItem *item1 = [[BAItem alloc] init];
    item1.itemName = @"Buy Milk";
    item1.thisTimeNote = @"Testing the note for the buy milk item";
    [sharedManager.toDoItems addObject:item1];
    
    BAItem *item2 = [[BAItem alloc] init];
    item2.itemName = @"Do Homework";
    item2.thisTimeNote = @"Homework note";
    [sharedManager.toDoItems addObject:item2];
    
    BAItem *item3 = [[BAItem alloc] init];
    item3.itemName = @"Read Textbook";
    item3.thisTimeNote = @"Textbook note";
    [sharedManager.toDoItems addObject:item3];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    sharedManager = [BAModel sharedManager];
    [self loadInitialData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [sharedManager.toDoItems count];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    sharedManager.activeItem = indexPath;
}

- (IBAction)unwindToMainMenu:(UIStoryboardSegue*)sender
{
        [self.tableView reloadData];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    static NSString *simpleTableIdentifier = @"ToDoItemCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    BAItem *toDoItem = [sharedManager.toDoItems objectAtIndex: indexPath.row];
    cell.textLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size: 18];
    cell.textLabel.text = toDoItem.itemName;
    
    return cell;
}


- (void)tableView:(UITableView *)tableView
commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        //add code here to do what you want when you hit delete
        [sharedManager.toDoItems removeObjectAtIndex:[indexPath row]];
        [tableView reloadData];
    }
}

@end
