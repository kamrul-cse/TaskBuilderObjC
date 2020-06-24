//
//  TaskManager.h
//  TaskBuilderObjC
//
//  Created by Md. Kamrul Hasan on 24/6/20.
//  Copyright © 2020 MKHG Lab. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TaskViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TaskManager: NSObject
@property (strong, nonatomic) NSMutableArray<TaskViewModel *>* taskViewModels;
@end

@implementation TaskManager
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
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    for (int i=0; i<_taskViewModels.count; i++) {
        [queue addOperation:_taskViewModels[i].model];
    }
}

@end

NS_ASSUME_NONNULL_END
