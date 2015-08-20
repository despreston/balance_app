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

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIFontDescriptor *fontD = [self.label1.font.fontDescriptor fontDescriptorWithSymbolicTraits:UIFontDescriptorTraitBold];
    
    [self.question1 setFont:[UIFont fontWithDescriptor:fontD size:self.label1.font.pointSize]];
    
    [self.question2 setFont:[UIFont fontWithDescriptor:fontD size:self.label1.font.pointSize]];
    // Do any additional setup after loading the view from its nib.
}
- (void) viewDidAppear:(BOOL)animated {
}

- (IBAction)guideTapGesture:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
