//
//  Task.m
//  TaskBuilderObjC
//
//  Created by Md. Kamrul Hasan on 24/6/20.
//  Copyright © 2020 MKHG Lab. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TaskDelegate.h"

@interface Task: NSOperation
@property (strong, nonatomic) NSString* taskName;
@property (strong, nonatomic) NSArray<NSString*>* dependentTasks;
@property int estimatedTime;
@property float taskProgress;
@property BOOL stopQueued;

@property (nonatomic, weak) id <TaskDelegate> delegate;

@end

@implementation Task
@synthesize delegate;

-(id)initWithName:(NSString *)taskName_ time:(int)estimatedTime_
{
     self = [super init];
     if (self) {
         self.taskName = taskName_;
         self.estimatedTime = estimatedTime_;
         self.taskProgress = 0.0;
         self.stopQueued = NO;
     }
     return self;
}

- (void)main {
    int initialValue = MIN(1, (int)_taskProgress);
    for (int i=initialValue; i<=_estimatedTime; i++) {
        _taskProgress = (float)i/_estimatedTime * 100;
        [delegate progress: _taskName progress: _taskProgress];
        if ( i == _estimatedTime || i == 1 ) {
            [delegate stateChanged: _taskName progress: _taskProgress];
        }
        [NSThread sleepForTimeInterval:1.0f];
    }
}
@end
