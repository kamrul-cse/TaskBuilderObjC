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

//- (void) configure: (Task*)task_ {
//    _nameLabel.text = task_.taskName;
//    //_statusLabel.text = [NSString stringWithFormat:@"%0.1f", task_.taskProgress];
//}

+ (UINib*) getNib {
    return [UINib nibWithNibName:@"TaskCell" bundle:nil];
}

+ (TaskCell*) getCell {
    TaskCell* cell = (TaskCell*) [[[NSBundle mainBundle] loadNibNamed:@"TaskCell" owner:self options:NULL] firstObject];
    return cell;
}

@end
