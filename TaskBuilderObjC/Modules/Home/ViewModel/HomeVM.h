//
//  HomeVM.h
//  TaskBuilderObjC
//
//  Created by Md. Kamrul Hasan on 25/6/20.
//  Copyright © 2020 MKHG Lab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TaskManager.h"
#import "HomeVMDelegate.h"

@interface HomeVM: NSObject <TaskManagerDelegate>
@property (strong, nonatomic) NSMutableArray<UITableViewCell*>* rows;

@property (nonatomic, weak) id <HomeVMDelegate> delegate;
@end

@implementation HomeVM
@synthesize rows;

- (void) start {
    [[TaskManager sharedTaskManager] setDelegate:self];
    [[TaskManager sharedTaskManager] start];
    
}

- (void) setupMockData {
    
    rows = [[NSMutableArray alloc] init];
    [rows addObject: [self getCell:@"Pending Tasks"]];
    
    
    NSMutableArray<TaskViewModel*>* vms = [[TaskManager sharedTaskManager] setupMockData];
    for (int i=0; i<vms.count; i++) {
        TaskViewModel *taskVM = vms[i];
        [rows addObject:taskVM.cell];
    }
}

- (void) refreshData {
    NSMutableArray *pending = [[NSMutableArray alloc] init];
    NSMutableArray *running = [[NSMutableArray alloc] init];
    NSMutableArray *completed = [[NSMutableArray alloc] init];
    
    NSArray<TaskViewModel*> *array = [[TaskManager sharedTaskManager] getData];
    [array enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        TaskViewModel *viewModel = (TaskViewModel*) obj;
        if (viewModel.model.taskProgress == 100) {
            [completed addObject:viewModel];
        } else if (viewModel.model.isExecuting) {
            [running addObject:viewModel];
        } else {
            [pending addObject:viewModel];
        }
    }];
    
    [rows removeAllObjects];
    if (pending.count > 0) {
        UITableViewCell *cell = [self getCell:@"Pending Tasks"];
        [rows addObject:cell];
        
        for (int i=0; i<pending.count; i++) {
            TaskViewModel *taskVM = pending[i];
            [rows addObject:taskVM.cell];
        }
    }
    
    if (running.count > 0) {
        UITableViewCell *cell = [self getCell:@"Running Tasks"];
        [rows addObject:cell];
        
        for (int i=0; i<running.count; i++) {
            TaskViewModel *taskVM = running[i];
            [rows addObject:taskVM.cell];
        }
    }
    
    if (completed.count > 0) {
        UITableViewCell *cell = [self getCell:@"Completed Tasks"];
        [rows addObject:cell];
        
        for (int i=0; i<completed.count; i++) {
            TaskViewModel *taskVM = completed[i];
            [rows addObject:taskVM.cell];
        }
    }
    
    [_delegate dataUpdated];
}

- (UITableViewCell*) getCell: (NSString*) title {
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    cell.textLabel.text = title;
    cell.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.25];
    return cell;
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

@end
