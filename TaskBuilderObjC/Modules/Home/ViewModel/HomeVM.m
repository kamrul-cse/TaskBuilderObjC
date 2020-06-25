//
//  HomeVM.m
//  TaskBuilderObjC
//
//  Created by Md. Kamrul Hasan on 25/6/20.
//  Copyright © 2020 MKHG Lab. All rights reserved.
//

#import "HomeVM.h"

@implementation HomeVM
@synthesize rows;
@synthesize runningTasks;
@synthesize canResume;
@synthesize haveTasks;
@synthesize havePending;
@synthesize operationRunning;

- (instancetype)init
{
    self = [super init];
    if (self) {
        rows = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void) start {
    [[TaskManager sharedTaskManager] setDelegate:self];
    [[TaskManager sharedTaskManager] start];
    operationRunning = YES;
}

- (void) stop {
    [[TaskManager sharedTaskManager] stop];
    operationRunning = NO;
}

- (void) removeAll {
    [[TaskManager sharedTaskManager] removeAll];
    [rows removeAllObjects];
    [rows addObject: [TaskViewModel getCell:@"No Tasks Found"] ];
    haveTasks = NO;
    operationRunning = NO;
}

- (void) setupMockData {
    
    rows = [[NSMutableArray alloc] init];
    [rows addObject: [TaskViewModel getCell:@"Pending Tasks"]];
    
    
    NSMutableArray<TaskViewModel*>* vms = [[TaskManager sharedTaskManager] setupMockData];
    for (int i=0; i<vms.count; i++) {
        TaskViewModel *taskVM = vms[i];
        [rows addObject:taskVM.cell];
    }
    haveTasks = YES;
}

- (void) refreshData {
    NSArray<TaskViewModel*> *array = [[TaskManager sharedTaskManager] getData];
    canResume = NO;
    runningTasks = NO;
    havePending = NO;
    haveTasks = NO;
    if (array.count == 0) {
        [rows addObject: [TaskViewModel getCell:@"No Tasks Found"] ];
        return;
    }
    haveTasks = YES;
    
    NSMutableArray *pending = [[NSMutableArray alloc] init];
    NSMutableArray *running = [[NSMutableArray alloc] init];
    NSMutableArray *completed = [[NSMutableArray alloc] init];
    
    haveTasks = array.count == 0 ? NO : YES;
    [array enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        TaskViewModel *viewModel = (TaskViewModel*) obj;
//        if (viewModel.model.isExecuting) {
//            runningTasks = YES;
//        }
//        if (viewModel.model.isExecuting || viewModel.model.isFinished) {
//            canResume = YES;
//        }
        if (viewModel.model.taskProgress == 100) {
            [completed addObject:viewModel];
        } else if (viewModel.model.isExecuting || viewModel.model.taskProgress > 0) {
            [running addObject:viewModel];
        } else {
            [pending addObject:viewModel];
        }
    }];
    
    [rows removeAllObjects];
    if (pending.count > 0) {
        UITableViewCell *cell = [TaskViewModel getCell:@"Pending Tasks"];
        [rows addObject:cell];
        
        for (int i=0; i<pending.count; i++) {
            TaskViewModel *taskVM = pending[i];
            [rows addObject:taskVM.cell];
        }
        havePending = YES;
    }
    
    if (running.count > 0) {
        UITableViewCell *cell = [TaskViewModel getCell:@"Running Tasks"];
        [rows addObject:cell];
        
        for (int i=0; i<running.count; i++) {
            TaskViewModel *taskVM = running[i];
            [rows addObject:taskVM.cell];
        }
        canResume = YES;
        runningTasks = YES;
    }
    
    if (completed.count > 0) {
        UITableViewCell *cell = [TaskViewModel getCell:@"Completed Tasks"];
        [rows addObject:cell];
        
        for (int i=0; i<completed.count; i++) {
            TaskViewModel *taskVM = completed[i];
            [rows addObject:taskVM.cell];
        }
    }
    
    if (!havePending && !canResume) {
        operationRunning = NO;
        [[TaskManager sharedTaskManager] reset];
    }
    
    [_delegate dataUpdated];
}

- (NSMutableArray<UITableViewCell*>*) getRows {
    return rows;
}

#pragma mark - TaskManagerDelegate
- (void)stateChanged:(NSString *)taskName_ progress:(float)value_ {
    dispatch_async(dispatch_get_main_queue(), ^{
        __weak HomeVM *weakSelf = self;
        [weakSelf refreshData];
    });
}

- (void)dataUpdated {
    [self refreshData];
}
@end
