//
//  AddNoteViewController.m
//  ToDoList
//
//  Created by Desmond Preston on 2/16/15.
//  Copyright (c) 2015 Desmond Preston. All rights reserved.
//

#import "AddNoteViewController.h"

@interface AddNoteViewController ()
@property (weak, nonatomic) IBOutlet UIBarButtonItem *saveButton;
@property (weak, nonatomic) IBOutlet UILabel *lblPlaceHolderText;

@end

@implementation AddNoteViewController

@synthesize toDoItem;
@synthesize itemNote;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.itemNote.textContainerInset = UIEdgeInsetsMake(64.0, 5.0, 0.0, 5.0);
    self.itemNote.text = toDoItem.note;

}


@end
