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
@property (nonatomic) BOOL canResume;
@property (nonatomic) BOOL runningTasks;
@property (nonatomic) BOOL haveTasks;
@property (nonatomic) BOOL havePending;
@property (nonatomic) BOOL operationRunning;

@property (nonatomic, weak) id <HomeVMDelegate> delegate;

// methods
- (void) start;
- (void) stop;
- (void) removeAll;
- (void) setupMockData;
- (void) refreshData;
- (NSMutableArray<UITableViewCell*>*) getRows;
@end
