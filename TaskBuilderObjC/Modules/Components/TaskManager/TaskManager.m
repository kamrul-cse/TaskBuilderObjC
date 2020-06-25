//
//  TaskManager.m
//  TaskBuilderObjC
//
//  Created by Md. Kamrul Hasan on 25/6/20.
//  Copyright © 2020 MKHG Lab. All rights reserved.
//

#import "TaskManager.h"

@implementation TaskManager
@synthesize delegate;

static TaskManager *_shared = nil;

+ (TaskManager *) sharedTaskManager {
    @synchronized([TaskManager class]) {
        if (!_shared)
          _shared = [[self alloc] init];
        return _shared;
    }
    return nil;
}
//SINGLETON_FOR_CLASS(YourSingletonClass)

- (void) add:(TaskViewModel*)taskVM {
    if (_taskViewModels == NULL) {
        _taskViewModels = [[NSMutableArray<TaskViewModel *> alloc] init];
    }
    [_taskViewModels addObject: taskVM];
    [self bindDependencies];
    
    [delegate dataUpdated];
}

- (void) removeAll {
    [self stop];
    [_taskViewModels removeAllObjects];
}

- (void) start {
    _queue = [[NSOperationQueue alloc] init];
    for (int i=0; i<_taskViewModels.count; i++) {
        [_queue addOperation:_taskViewModels[i].model];
    }
}

- (void) stop {
    for (int i=0; i<_taskViewModels.count; i++) {
        _taskViewModels[i].model.stopQueued = YES;
    }
    [_queue cancelAllOperations];
    [self setupForResumeOperation];
}

- (void) reset {
    for (int i=0; i<_taskViewModels.count; i++) {
        _taskViewModels[i].model.taskProgress = 0;
        [_taskViewModels[i] setup:_taskViewModels[i].dependencies];
    }
    [_queue cancelAllOperations];
    [self setupForResumeOperation];
}

- (void) setupForResumeOperation {
    NSMutableArray<TaskViewModel*>* rows = _taskViewModels;
    for (int i=0; i<rows.count; i++) {
        rows[i].model = [rows[i].model getCopy];
    }
    
    [self bindDependencies];
}

- (NSMutableArray<TaskViewModel *>*) setupMockData {
    NSMutableArray<TaskViewModel*>* rows = [[NSMutableArray alloc] init];
    [rows addObject: [TaskViewModel getTaskVM:@"Man" time:10 dependencies:NULL delegate:self]];
    [rows addObject: [TaskViewModel getTaskVM:@"Woman" time:5 dependencies:NULL delegate:self]];
    [rows addObject: [TaskViewModel getTaskVM:@"Child" time:8 dependencies:@[@"Woman"] delegate:self]];
    [rows addObject: [TaskViewModel getTaskVM:@"Baby" time:10 dependencies:@[@"Woman", @"Child"] delegate:self]];
    
    _taskViewModels = rows;
    [self bindDependencies];
    
    return _taskViewModels;
}

- (void) bindDependencies {
    for (int i=0; i<_taskViewModels.count; i++) {
        TaskViewModel *taskVM = _taskViewModels[i];
        NSArray *dependencies = _taskViewModels[i].dependencies;
        for (int j=0; j<dependencies.count; j++) {
            NSString *taskName = dependencies[j];
            Task *dependentTask = [self getTaskVM:taskName].model;
            NSLog(@"`%@` will be waiting for `%@`", taskVM.model.taskName, dependentTask.taskName);
            [taskVM.model addDependency:dependentTask];
        }
    }
}

- (NSMutableArray<TaskViewModel *>*) getData {
    return _taskViewModels;
}

- (TaskViewModel *) getTaskVM: (NSString*)taskName_ {
    for (int i=0; i<_taskViewModels.count; i++) {
        if ([[_taskViewModels[i].model.taskName lowercaseString] isEqualToString:[taskName_ lowercaseString]]) {
            return _taskViewModels[i];
        }
    }
    return NULL;
}

#pragma mark - TaskViewModelDelegate
- (void)stateChanged:(NSString *)taskName_ progress:(float)value_ {
    [delegate stateChanged:taskName_ progress:value_];
}

@end