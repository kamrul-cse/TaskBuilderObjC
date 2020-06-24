//
//  Task.m
//  TaskBuilderObjC
//
//  Created by Md. Kamrul Hasan on 24/6/20.
//  Copyright © 2020 MKHG Lab. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TaskDelegate.h"

@interface Task: NSOperation {
    id delegate;
}
@property (strong, nonatomic) NSString* taskName;
@property int estimatedTime;
@property double progress;
@property (strong, nonatomic) NSArray<NSString*>* dependentTasks;
@property BOOL stopQueued;
@end

@implementation Task

-(id)initWithName:(NSString *)taskName_ time:(int)estimatedTime_
{
     self = [super init];
     if (self) {
         self.taskName = taskName_;
         self.estimatedTime = estimatedTime_;
         self.progress = 0.0;
         self.stopQueued = NO;
     }
     return self;
}

- (void)main {
    for (int i=1; i<=_estimatedTime; i++) {
        NSLog(@"%@ %d", _taskName, i);
        if ( i == _estimatedTime ) {
            NSLog(@"%@ completed", _taskName);
        }
        [NSThread sleepForTimeInterval:1.0f];
    }
}
@end
