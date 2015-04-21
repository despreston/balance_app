//
//  Note.m
//  Balance
//
//  Created by Desmond Preston on 2/16/15.
//  Copyright (c) 2015 Desmond Preston. All rights reserved.
//

#import "BAModel.h"

@implementation BAModel

@synthesize toDoItems;
@synthesize activeItem;

#pragma mark Singleton Methods

+ (id)sharedManager {
    static BAModel *sharedBAModel = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedBAModel = [[self alloc] init];
    });
    return sharedBAModel;
}

- (id)init {
    if (self = [super init]) {
        toDoItems = [[NSMutableArray alloc]init];
        activeItem = NULL;
    }
    return self;
}

- (void)dealloc {
    // Should never be called, but just here for clarity really.
}

@end
