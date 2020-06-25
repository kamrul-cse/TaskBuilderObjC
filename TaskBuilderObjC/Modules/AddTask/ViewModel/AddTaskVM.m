//
//  AddTaskVM.m
//  TaskBuilderObjC
//
//  Created by Md. Kamrul Hasan on 25/6/20.
//  Copyright © 2020 MKHG Lab. All rights reserved.
//

#import "AddTaskVM.h"

@implementation AddTaskVM

- (NSString*) checkError: (NSString*)name_ time: (NSString*)time_ dependency:(NSString*)dependency_ {
    
    if ([name_ isEqual:NULL] || name_.length == 0) {
        return @"Invalid Task Name";
    }
    if ([time_ isEqual:NULL] || time_.length == 0 || time_.intValue <= 0) {
        return @"Invalid Estimated Time";
    }
    
    return NULL;
}

- (TaskViewModel*) getTaskVM:(NSString*)name_ time: (NSString*)time_ dependency:(NSString*)dependency_ {
    NSString *error = [self checkError:name_ time:time_ dependency:dependency_];
    if (error == NULL) {
        TaskViewModel *taskVM = [TaskViewModel constructTaskVM:name_ time:time_ dependency:dependency_];
        return taskVM;
    } else {
        return NULL;
    }
}

@end
