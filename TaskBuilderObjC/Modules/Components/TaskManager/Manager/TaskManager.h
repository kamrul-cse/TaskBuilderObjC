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

// methods
// singleton for task manager
+ (TaskManager *) sharedTaskManager;

- (void) add:(TaskViewModel*)taskVM;
- (void) removeAll;
- (void) start;
- (void) stop;
- (void) reset;
- (NSMutableArray<TaskViewModel *>*) setupMockData;
- (NSMutableArray<TaskViewModel *>*) getData;
- (void) bindDependencies;
@end
