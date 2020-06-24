//
//  HomeVC.m
//  TaskBuilderObjC
//
//  Created by Md. Kamrul Hasan on 24/6/20.
//  Copyright © 2020 MKHG Lab. All rights reserved.
//

#import "HomeVC.h"
#import "RowData.h"
#import "Task.h"
#import "TaskManager.h"

@interface HomeVC () <UITableViewDelegate, UITableViewDataSource> {
    NSMutableArray<TaskViewModel*> *rows;
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *startButton;

@end

@implementation HomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    rows = [[NSMutableArray alloc] init];
    [rows addObject: [TaskViewModel getTaskVM:@"Man" time:10]];
    [rows addObject: [TaskViewModel getTaskVM:@"Woman" time:5]];
    [rows addObject: [TaskViewModel getTaskVM:@"Baby" time:10]];
    
    [[rows[2] model] addDependency: [rows[1] model]];
    
    _tableView.tableFooterView = [[UIView alloc] init];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    
    TaskManager *manager = [TaskManager sharedTaskManager];
    
    NSEnumerator *e = [rows objectEnumerator];
    id object;
    while (object = [e nextObject]) {
        [manager add: object];
    }
    
    
    [manager start];
}

- (RowData*)getRowData:(NSString*)title {
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    cell.textLabel.text = title;
    RowData *data = [[RowData alloc] init];
    data.cell = cell;
    return data;
}

- (IBAction)startTapped:(id)sender {
    
}

- (IBAction)trashTapped:(id)sender {
    
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return rows.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return rows[indexPath.row].cell;
}

@end
