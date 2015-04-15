//
//  AddNoteViewController.h
//  Balance
//
//  Created by Desmond Preston on 2/16/15.
//  Copyright (c) 2015 Desmond Preston. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BAItem.h"

@interface AddNoteViewController : UIViewController

@property (nonatomic, strong) BAItem *toDoItem;
@property (weak, nonatomic) IBOutlet UITextView *itemNote;

@end
