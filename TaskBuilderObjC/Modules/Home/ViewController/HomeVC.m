//
//  HomeVC.m
//  TaskBuilderObjC
//
//  Created by Md. Kamrul Hasan on 24/6/20.
//  Copyright © 2020 MKHG Lab. All rights reserved.
//

#import "HomeVC.h"

@interface HomeVC () <HomeVMDelegate, UITableViewDelegate, UITableViewDataSource> {
    NSMutableArray<UITableViewCell*> *rows;
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *startButton;

@end

@implementation HomeVC
@synthesize viewModel;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    viewModel = [[HomeVM alloc] init];
    viewModel.delegate = self;
    
    rows = [viewModel getRows];
    
    _tableView.tableFooterView = [[UIView alloc] init];
    _tableView.delegate = self;
    _tableView.dataSource = self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [viewModel refreshData];
    if (viewModel.haveTasks) {
        [_startButton setTitle:@"Start" forState:UIControlStateNormal];
    } else {
        [_startButton setTitle:@"Simulate Mock Tasks" forState:UIControlStateNormal];
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    if (viewModel.runningTasks) {
        [self stopAction];
    }
}

- (IBAction)startTapped:(id)sender {
    //_startButton. = NO;
    [_startButton setHidden:YES];
    [self performSelector:@selector(enableStartButton) withObject:nil afterDelay:1.0];
    
    if ([_startButton.titleLabel.text  isEqual: @"Simulate Mock Tasks"]) {
        NSLog(@"Simulate Mock Tasks tapped -------------------------------------");
        [viewModel setupMockData];
        rows = [viewModel getRows];
        [_tableView reloadData];
        [_startButton setTitle:@"Start" forState:UIControlStateNormal];
    } else if ([_startButton.titleLabel.text  isEqual: @"Stop"]) {
        NSLog(@"Stop tapped -------------------------------------");
        [self stopAction];
    } else if ([_startButton.titleLabel.text  isEqual: @"Resume"]) {
        NSLog(@"Resume tapped -----------------------------------");
        [viewModel start];
        [_startButton setTitle:@"Resume" forState:UIControlStateNormal];
    } else {
        NSLog(@"Start tapped XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX");
        [viewModel start];
    }
}

- (void) enableStartButton {
    //_startButton.userInteractionEnabled = YES;
    [_startButton setHidden:NO];
}

- (void) stopAction {
    [viewModel stop];
    [_startButton setTitle:@"Resume" forState:UIControlStateNormal];
}

- (IBAction)trashTapped:(id)sender {
    NSLog(@"trash tapped");
    [viewModel removeAll];
    [self dataUpdated];
}

#pragma mark - HomeVMDelegate
- (void)dataUpdated {
    rows = [viewModel getRows];
    dispatch_async(dispatch_get_main_queue(), ^{
        __weak HomeVC *weakSelf = self;
        [weakSelf.tableView reloadData];
        if (!weakSelf.viewModel.haveTasks) {
            [weakSelf.startButton setTitle:@"Simulate Mock Tasks" forState:UIControlStateNormal];
        } else if (weakSelf.viewModel.operationRunning) {
            [weakSelf.startButton setTitle:@"Stop" forState:UIControlStateNormal];
        } else if (weakSelf.viewModel.havePending && weakSelf.viewModel.canResume) {
            [weakSelf.startButton setTitle:@"Resume" forState:UIControlStateNormal];
        } else {
            [weakSelf.startButton setTitle:@"Start" forState:UIControlStateNormal];
        }
    });
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return rows.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return rows[indexPath.row];
}

@end
