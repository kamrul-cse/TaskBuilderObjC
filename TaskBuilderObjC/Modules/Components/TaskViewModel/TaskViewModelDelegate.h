//
//  TaskViewModelDelegate.h
//  TaskBuilderObjC
//
//  Created by Md. Kamrul Hasan on 25/6/20.
//  Copyright © 2020 MKHG Lab. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TaskViewModel.h"

@protocol TaskViewModelDelegate

- (void) stateChanged: (NSString*) taskName_ progress:(float)value_;

@end
