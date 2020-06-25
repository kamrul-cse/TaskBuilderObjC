//
//  TaskCell.m
//  TaskBuilderObjC
//
//  Created by Md. Kamrul Hasan on 25/6/20.
//  Copyright © 2020 MKHG Lab. All rights reserved.
//

#import "TaskCell.h"

@implementation TaskCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

+ (TaskCell*) getCell {
    TaskCell* cell = (TaskCell*) [[[NSBundle mainBundle] loadNibNamed:@"TaskCell" owner:self options:NULL] firstObject];
    return cell;
}

@end
