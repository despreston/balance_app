//
//  guide.m
//  Balance
//
//  Created by Desmond Preston on 8/19/15.
//  Copyright (c) 2015 Desmond Preston. All rights reserved.
//

#import "guide.h"

@interface guide ()
@end

@implementation guide

- (NSManagedObjectContext *)managedObjectContext
{
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    return context;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIFontDescriptor *fontD = [self.label1.font.fontDescriptor fontDescriptorWithSymbolicTraits:UIFontDescriptorTraitBold];
    
    [self.question1 setFont:[UIFont fontWithDescriptor:fontD size:self.label1.font.pointSize]];
    
    [self.question2 setFont:[UIFont fontWithDescriptor:fontD size:self.label1.font.pointSize]];
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)guideTapGesture:(id)sender {
    //NSManagedObjectContext *context = [self managedObjectContext];
    //self.User = [[context executeFetchRequest:[[NSFetchRequest alloc] initWithEntityName:@"User"] error:nil] mutableCopy];
    
    [self dismissViewControllerAnimated:YES completion:nil];
//    [self.User setValue:NO forKey:@"isNewUser"];
//    NSError *error = nil;
//    if (![context save:&error]) {
//        NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
//    } else {
//        NSLog(@"Is no longer a new user");
//    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
