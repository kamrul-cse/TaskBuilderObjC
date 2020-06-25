//
//  TaskViewModel.h
//  TaskBuilderObjC
//
//  Created by Md. Kamrul Hasan on 24/6/20.
//  Copyright © 2020 MKHG Lab. All rights reserved.
//



#import <Foundation/Foundation.h>
#import "Task.h"
#import "TaskCell.h"
#import "TaskViewModelDelegate.h"

@interface TaskViewModel: NSObject <TaskDelegate>
@property (strong, nonatomic) Task* model;
@property (strong, nonatomic) TaskCell* cell;
@property (strong, nonatomic) NSMutableArray<NSString*>* dependencies;
@property (nonatomic, weak) id <TaskViewModelDelegate> delegate;
@end

@implementation TaskViewModel
@synthesize delegate;

+ (TaskViewModel*) getTaskVM: (NSString*)name_ time:(int)estimatedTime_ delegate: (id <TaskViewModelDelegate>)delegate_ {
    Task *task = [[Task alloc] initWithName:name_ time:estimatedTime_];
    
    TaskCell *cell = [TaskCell getCell];
    cell.nameLabel.text = name_;
    cell.progressView.progress = 0;
    cell.statusLabel.text = @"";
    
    TaskViewModel *vm = [[TaskViewModel alloc] init];
    task.delegate = vm;
    vm.model = task;
    vm.cell = cell;
    vm.delegate = delegate_;
    
    vm.dependencies = [[NSMutableArray alloc] init];
    
    return vm;
}

- (void) addDepency: (NSString*)name_ {
    [_dependencies addObject:name_];
    _cell.statusLabel.text = [NSString stringWithFormat:@"Waiting for %@", [_dependencies componentsJoinedByString:@", "]];
}

- (void)configure:(NSString *)taskName_ progress:(double)value_ {
    dispatch_async(dispatch_get_main_queue(), ^{
        __weak TaskViewModel *weakSelf = self;
        weakSelf.cell.nameLabel.text = taskName_;
        weakSelf.cell.statusLabel.text = [NSString stringWithFormat:@"%0.1f%%", value_];
        weakSelf.cell.progressView.progress = value_/100;
        
        if (value_ == 100) {
            weakSelf.cell.statusLabel.text = @"Done";
            [weakSelf.cell.progressView setHidden:YES];
        }
    });
}



#pragma mark - TaskDelegate
- (void)progress:(NSString *)taskName_ progress:(float)value_ {
    NSLog(@"%@ %f", taskName_, value_);
    [self configure:taskName_ progress:value_];
}

- (void)stateChanged:(NSString *)taskName_ progress:(float)value_ {
    NSLog(@"%@ stateChanged %f", taskName_, value_);
    [delegate stateChanged:taskName_ progress:value_];
}

@end
