//
//  AddTaskVM.h
//  TaskBuilderObjC
//
//  Created by Md. Kamrul Hasan on 25/6/20.
//  Copyright © 2020 MKHG Lab. All rights reserved.
//
#import <UIKit/UIKit.h>

@interface AddTaskVM: NSObject
@end

@implementation AddTaskVM

- (NSString*) checkError: (NSString*)name_ time: (NSString*)time_ dependency:(NSString*)dependency_ {
    return @"OK";
}

@end
