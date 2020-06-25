//
//  TaskDelegate.h
//  TaskBuilderObjC
//
//  Created by Md. Kamrul Hasan on 24/6/20.
//  Copyright © 2020 MKHG Lab. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Task.h"

@protocol TaskDelegate

- (void) progress: (NSString*) taskName_ progress:(float)value_;
- (void) stateChanged: (NSString*) taskName_ progress:(float)value_;

@end
