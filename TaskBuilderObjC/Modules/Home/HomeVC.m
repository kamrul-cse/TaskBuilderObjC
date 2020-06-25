//
//  HomeVC.m
//  TaskBuilderObjC
//
//  Created by Md. Kamrul Hasan on 24/6/20.
//  Copyright © 2020 MKHG Lab. All rights reserved.
//

#import "HomeVC.h"
#import "Task.h"
#import "TaskManager.h"

@interface HomeVC () <TaskDelegate, UITableViewDelegate, UITableViewDataSource> {
    NSMutableArray<TaskViewModel*> *rows;
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *startButton;

@end

@implementation HomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    rows = [[TaskManager sharedTaskManager] setupMockData];
    
    _tableView.tableFooterView = [[UIView alloc] init];
    _tableView.delegate = self;
    _tableView.dataSource = self;
}

- (IBAction)startTapped:(id)sender {
    [[TaskManager sharedTaskManager] start];
}

- (IBAction)trashTapped:(id)sender {
    
}

#pragma mark - TaskDelegate
- (void)progress:(NSString *)taskName_ progress:(double)value_ {
    NSLog(@"%@ %f", taskName_, value_);
}

- (void)stateChanged:(NSString *)taskName_ progress:(double)value_ {
    NSLog(@"%@ stateChanged %f", taskName_, value_);
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return rows.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return rows[indexPath.row].cell;
}

@end
