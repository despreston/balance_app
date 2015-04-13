//
//  Note.h
//  Balance
//
//  Created by Desmond Preston on 2/16/15.
//  Copyright (c) 2015 Desmond Preston. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BAModel : NSObject {
    NSMutableArray *toDoItems;
}

@property (nonatomic, retain) NSMutableArray *toDoItems;

+ (id)sharedManager;

@end
