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
    
    //rows = [[TaskManager sharedTaskManager] setupMockData];
    [viewModel setupMockData];
    rows = [viewModel getRows];
    
    _tableView.tableFooterView = [[UIView alloc] init];
    _tableView.delegate = self;
    _tableView.dataSource = self;
}

- (IBAction)startTapped:(id)sender {
    if ([_startButton.titleLabel.text  isEqual: @"Stop"]) {
        NSLog(@"Stop tapped");
        [viewModel stop];
        [_startButton setTitle:@"Resume" forState:UIControlStateNormal];
    } else if ([_startButton.titleLabel.text  isEqual: @"Resume"]) {
        NSLog(@"Resume tapped");
        [viewModel start];
        [_startButton setTitle:@"Resume" forState:UIControlStateNormal];
    } else {
        NSLog(@"Start tapped");
        [viewModel start];
    }
    
}

- (IBAction)trashTapped:(id)sender {
    
}

#pragma mark - HomeVMDelegate
- (void)dataUpdated {
    rows = [viewModel getRows];
    dispatch_async(dispatch_get_main_queue(), ^{
        __weak HomeVC *weakSelf = self;
        [weakSelf.tableView reloadData];
        
        if (weakSelf.viewModel.canResume) {
            [weakSelf.startButton setTitle:@"Stop" forState:UIControlStateNormal];
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
