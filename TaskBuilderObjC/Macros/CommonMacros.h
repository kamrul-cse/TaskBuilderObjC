//
//  CommonMacros.h
//  TaskBuilderObjC
//
//  Created by Md. Kamrul Hasan on 24/6/20.
//  Copyright © 2020 MKHG Lab. All rights reserved.
//

#ifndef CommonMacros_h
#define CommonMacros_h

#define SINGLETON_FOR_CLASS(classname)
+ (id) shared##classname {
    static dispatch_once_t pred = 0;
    static id _sharedObject = nil;
    dispatch_once(&pred, ^{
        _sharedObject = [[self alloc] init];
    });
    return _sharedObject;
}

#endif /* CommonMacros_h */
