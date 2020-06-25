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

// methods
- (id)initWithName:(NSString *)taskName_ time:(int)estimatedTime_;
- (id)initWithName:(NSString *)taskName_ time:(int)estimatedTime_ progress:(float)progress_ delegate:(id <TaskDelegate>)delegate_;
- (Task*) getCopy;
@end
