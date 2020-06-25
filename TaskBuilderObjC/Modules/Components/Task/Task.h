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
@property NSTimeInterval completedOn;

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

-(id)initWithName:(NSString *)taskName_ time:(int)estimatedTime_ progress:(float)progress_ delegate:(id <TaskDelegate>)delegate_
{
     self = [super init];
     if (self) {
         self.taskName = taskName_;
         self.estimatedTime = estimatedTime_;
         self.taskProgress = progress_;
         self.stopQueued = NO;
         self.delegate = delegate_;
     }
     return self;
}

- (void)main {
    int initialValue = MAX(1, (int)((_taskProgress/100)*_estimatedTime));
    for (int i=initialValue; i<=_estimatedTime; i++) {
        if (_stopQueued) {
            [self cancel];
            NSLog(@"%@ stopped----------------", _taskName);
            return;
        }
        _taskProgress = (float)i/_estimatedTime * 100;
        [delegate progress: _taskName progress: _taskProgress];
        if ( i == _estimatedTime || i == initialValue ) {
            if (i == _estimatedTime) {
                _completedOn = [[NSDate date] timeIntervalSince1970];
            }
            [delegate stateChanged: _taskName progress: _taskProgress];
        }
        [NSThread sleepForTimeInterval:1.0f];
    }
}

- (Task*) getCopy {
    Task *task = [[Task alloc] initWithName:_taskName time:_estimatedTime progress:_taskProgress delegate:delegate];
    return task;
}
@end
