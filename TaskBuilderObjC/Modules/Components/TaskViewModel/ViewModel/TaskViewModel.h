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

// methods
+ (TaskViewModel*) getTaskVM: (NSString*)name_ time:(int)estimatedTime_ dependencies:(NSArray<NSString*>*)dependencies_ delegate: (id <TaskViewModelDelegate>)delegate_;

+ (TaskViewModel*) constructTaskVM: (NSString*)name_ time: (NSString*)time_ dependency:(NSString*)dependency_;

+ (UITableViewCell*) getCell: (NSString*) title;

- (void) setup:(NSArray*)dependencies_;
@end
