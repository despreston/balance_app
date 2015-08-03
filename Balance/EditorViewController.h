//
//  EditorViewController.h
//  Balance
//
//  Created by Desmond Preston on 6/5/15.
//  Copyright (c) 2015 Desmond Preston. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SJNotificationViewController.h"

@class EditorViewController;

@protocol EditorViewControllerDelegate <NSObject>
- (void)modifyItemFromEditor:(NSString *)note forNote:(NSString *)noteToEdit;
@end

@interface EditorViewController : UIViewController <UITextViewDelegate>;

- (IBAction)Done:(id)sender;
- (IBAction)ClearButtonPressed:(id)sender;
@property (nonatomic, weak) id <EditorViewControllerDelegate> editorDelegate;
@property (weak, nonatomic) IBOutlet UIButton *Cancel;
@property (weak, nonatomic) IBOutlet UITextView *note;
@property (weak, nonatomic) IBOutlet UIButton *Done;
@property (weak, nonatomic) NSString *noteToEdit;
@property (weak, nonatomic) NSString *editNote;
@property (weak, nonatomic) IBOutlet UIButton *ClearButton;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *note_bottom;

@end
