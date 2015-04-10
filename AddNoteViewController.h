//
//  AddNoteViewController.h
//  Balance
//
//  Created by Desmond Preston on 2/16/15.
//  Copyright (c) 2015 Desmond Preston. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ToDoItem.h"

@interface AddNoteViewController : UIViewController

@property (nonatomic, strong) ToDoItem *toDoItem;
@property (weak, nonatomic) IBOutlet UITextView *itemNote;

@end
