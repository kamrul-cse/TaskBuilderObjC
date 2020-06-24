//
//  TaskViewModel.h
//  TaskBuilderObjC
//
//  Created by Md. Kamrul Hasan on 24/6/20.
//  Copyright © 2020 MKHG Lab. All rights reserved.
//



#ifndef TaskViewModel_h
#define TaskViewModel_h

NS_ASSUME_NONNULL_BEGIN

@interface TaskViewModel: NSObject
@property (strong, nonatomic) Task* model;
@property (strong, nonatomic) UITableViewCell* cell;
@end

@implementation TaskViewModel

+ (TaskViewModel*) getTaskVM: (NSString*)name_ time:(int)estimatedTime_ {
    Task *task = [[Task alloc] initWithName:name_ time:estimatedTime_];
    
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    cell.textLabel.text = name_;
    
    TaskViewModel *vm = [[TaskViewModel alloc] init];
    vm.model = task;
    vm.cell = cell;
    
    return vm;
}

@end

NS_ASSUME_NONNULL_END

#endif /* TaskViewModel_h */
