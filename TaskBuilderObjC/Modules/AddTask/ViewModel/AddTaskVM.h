//
//  AddTaskVM.h
//  TaskBuilderObjC
//
//  Created by Md. Kamrul Hasan on 25/6/20.
//  Copyright © 2020 MKHG Lab. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "TaskManager.h"

@interface AddTaskVM: NSObject

// methods
- (NSString*) checkError: (NSString*)name_ time: (NSString*)time_ dependency:(NSString*)dependency_;
- (TaskViewModel*) getTaskVM:(NSString*)name_ time: (NSString*)time_ dependency:(NSString*)dependency_;
@end
