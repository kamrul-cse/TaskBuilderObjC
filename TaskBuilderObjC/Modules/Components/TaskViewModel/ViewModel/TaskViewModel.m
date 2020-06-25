//
//  TaskViewModel.m
//  TaskBuilderObjC
//
//  Created by Md. Kamrul Hasan on 25/6/20.
//  Copyright © 2020 MKHG Lab. All rights reserved.
//

#import "TaskViewModel.h"

@implementation TaskViewModel
@synthesize delegate;

+ (TaskViewModel*) getTaskVM: (NSString*)name_ time:(int)estimatedTime_ dependencies:(NSArray<NSString*>*)dependencies_ {
    Task *task = [[Task alloc] initWithName:name_ time:estimatedTime_];
    
    TaskCell *cell = [TaskCell getCell];
    cell.nameLabel.text = name_;
    cell.progressView.progress = 0;
    cell.statusLabel.text = NULL;
    
    TaskViewModel *vm = [[TaskViewModel alloc] init];
    task.delegate = vm;
    vm.model = task;
    vm.cell = cell;
    
    [vm setup:dependencies_];
    
    return vm;
}

+ (TaskViewModel*) getTaskVM: (NSString*)name_ time:(int)estimatedTime_ dependencies:(NSArray<NSString*>*)dependencies_ delegate: (id <TaskViewModelDelegate>)delegate_ {
    Task *task = [[Task alloc] initWithName:name_ time:estimatedTime_];
    
    TaskCell *cell = [TaskCell getCell];
    cell.nameLabel.text = name_;
    cell.progressView.progress = 0;
    cell.statusLabel.text = NULL;
    
    TaskViewModel *vm = [[TaskViewModel alloc] init];
    task.delegate = vm;
    vm.model = task;
    vm.cell = cell;
    vm.delegate = delegate_;
    
    [vm setup:dependencies_];
    
    return vm;
}

- (void) clearDependencies {
    _dependencies = [[NSMutableArray alloc] init];
}

- (void) addDepency: (NSString*)name_ {
    [_dependencies addObject:name_];
    if (_model.taskProgress > 0) {
        _cell.statusLabel.text = [NSString stringWithFormat:@"%0.1f%%", _model.taskProgress];
    } else if (_model.taskProgress == 100) {
        _cell.statusLabel.text = @"Done";
    } else {
        _cell.statusLabel.text = [NSString stringWithFormat:@"Depends on %@", [_dependencies componentsJoinedByString:@", "]];
    }
    
}

- (void) setup:(NSArray*)dependencies_ {
    if (dependencies_.count > 0) {
        _cell.statusLabel.text = [NSString stringWithFormat:@"Depends on %@", [dependencies_ componentsJoinedByString:@", "]];
        _dependencies = [[NSMutableArray alloc] initWithArray:dependencies_];
    } else {
        _cell.statusLabel.text = NULL;
    }
}

- (void)configure:(NSString *)taskName_ progress:(double)value_ {
    dispatch_async(dispatch_get_main_queue(), ^{
        __weak TaskViewModel *weakSelf = self;
        weakSelf.cell.nameLabel.text = taskName_;
        weakSelf.cell.progressView.progress = value_/100;
        
        if (value_ == 100) {
            weakSelf.cell.statusLabel.text = @"Done";
            [weakSelf.cell.progressView setHidden:YES];
        } else {
            if (weakSelf.model.isExecuting) {
                weakSelf.cell.statusLabel.text = [NSString stringWithFormat:@"%0.1f%%", value_];
            }
            [weakSelf.cell.progressView setHidden:NO];
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


+ (TaskViewModel*) constructTaskVM: (NSString*)name_ time: (NSString*)time_ dependency:(NSString*)dependency_ {
    Task *task = [[Task alloc] initWithName:name_ time:time_.intValue];
    
    TaskCell *cell = [TaskCell getCell];
    cell.nameLabel.text = name_;
    cell.progressView.progress = 0;
    cell.statusLabel.text = @"";
    
    TaskViewModel *vm = [[TaskViewModel alloc] init];
    task.delegate = vm;
    vm.model = task;
    vm.cell = cell;
    
    if (dependency_.length > 0) {
        NSArray *dependencies_ = [dependency_ componentsSeparatedByString:@","];
        if (dependencies_.count > 0) {
            [vm setup:dependencies_];
        }
    }
    
    return vm;
}

+ (UITableViewCell*) getCell: (NSString*) title {
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    cell.textLabel.text = title;
    cell.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.25];
    return cell;
}

@end
