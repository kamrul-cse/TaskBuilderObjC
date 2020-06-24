//
//  HomeVC.m
//  TaskBuilderObjC
//
//  Created by Md. Kamrul Hasan on 24/6/20.
//  Copyright © 2020 MKHG Lab. All rights reserved.
//

#import "HomeVC.h"

@interface HomeVC ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *startButton;

@end

@implementation HomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _tableView.tableFooterView = [[UIView alloc] init];
}
- (IBAction)startTapped:(id)sender {
    
}

- (IBAction)trashTapped:(id)sender {
    
}

@end
