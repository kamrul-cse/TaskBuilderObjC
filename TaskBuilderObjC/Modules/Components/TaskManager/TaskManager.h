//
//  TaskManager.h
//  TaskBuilderObjC
//
//  Created by Md. Kamrul Hasan on 24/6/20.
//  Copyright © 2020 MKHG Lab. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TaskViewModel.h"
#import "TaskManagerDelegate.h"

@interface TaskManager: NSObject <TaskViewModelDelegate>
@property (strong, nonatomic) NSMutableArray<TaskViewModel *>* taskViewModels;
@property (strong, nonatomic) NSOperationQueue *queue;

@property (nonatomic, weak) id <TaskManagerDelegate> delegate;
@end

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
    }
    [_queue cancelAllOperations];
    [self setupForResumeOperation];
}

- (void) setupForResumeOperation {
    NSMutableArray<TaskViewModel*>* rows = _taskViewModels;
    for (int i=0; i<rows.count; i++) {
        rows[i].model = [rows[i].model getCopy];
        [rows[i] clearDependencies];
    }
    
    [[rows[2] model] addDependency: [rows[1] model]];
    [rows[2] addDepency:rows[1].model.taskName];
    
    [[rows[3] model] addDependency: [rows[2] model]];
    [[rows[3] model] addDependency: [rows[1] model]];
    [rows[3] addDepency:rows[1].model.taskName];
    [rows[3] addDepency:rows[2].model.taskName];
}

- (NSMutableArray<TaskViewModel *>*) setupMockData {
    NSMutableArray<TaskViewModel*>* rows = [[NSMutableArray alloc] init];
    [rows addObject: [TaskViewModel getTaskVM:@"Man" time:10 delegate:self]];
    [rows addObject: [TaskViewModel getTaskVM:@"Woman" time:5 delegate:self]];
    [rows addObject: [TaskViewModel getTaskVM:@"Child" time:8 delegate:self]];
    [rows addObject: [TaskViewModel getTaskVM:@"Baby" time:10 delegate:self]];
    
    [[rows[2] model] addDependency: [rows[1] model]];
    [rows[2] addDepency:rows[1].model.taskName];
    
    [[rows[3] model] addDependency: [rows[2] model]];
    [[rows[3] model] addDependency: [rows[1] model]];
    [rows[3] addDepency:rows[1].model.taskName];
    [rows[3] addDepency:rows[2].model.taskName];
    
    _taskViewModels = rows;
    
    return _taskViewModels;
}

- (NSMutableArray<TaskViewModel *>*) getData {
    return _taskViewModels;
}

#pragma mark - TaskViewModelDelegate
- (void)stateChanged:(NSString *)taskName_ progress:(float)value_ {
    [delegate stateChanged:taskName_ progress:value_];
}

@end
