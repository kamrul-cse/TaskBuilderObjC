//
//  PerformTaskVC.m
//  TaskBuilderObjC
//
//  Created by Md. Kamrul Hasan on 24/6/20.
//  Copyright © 2020 MKHG Lab. All rights reserved.
//

#import "PerformTaskVC.h"

@interface PerformTaskVC ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation PerformTaskVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _tableView.tableFooterView = [[UIView alloc] init];
}


@end
