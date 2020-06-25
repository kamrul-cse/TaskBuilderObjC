//
//  AddTaskVC.m
//  TaskBuilderObjC
//
//  Created by Md. Kamrul Hasan on 24/6/20.
//  Copyright © 2020 MKHG Lab. All rights reserved.
//

#import "AddTaskVC.h"

@interface AddTaskVC ()
@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *timeField;
@property (weak, nonatomic) IBOutlet UITextField *dependencyField;
@property (weak, nonatomic) IBOutlet UILabel *messageLabel;

@end

@implementation AddTaskVC
@synthesize viewModel;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    viewModel = [[AddTaskVM alloc] init];
}

- (IBAction)addTapped:(id)sender {
    NSString *name = [_nameField.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSString *time = _timeField.text;
    NSString *dependency = [_dependencyField.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    NSString *error = [viewModel checkError:name time:time dependency:dependency];
    _messageLabel.text = error;
    
    if (error == NULL) {
        [_messageLabel setHidden:YES];
        
        TaskViewModel *taskVM = [viewModel getTaskVM:name time:time dependency:dependency];
        NSLog(@"%@ created", taskVM.model.taskName);
        
        taskVM.delegate = [TaskManager sharedTaskManager];
        [[TaskManager sharedTaskManager] add:taskVM];
        
        [self.navigationController popViewControllerAnimated:true];
    } else {
        [_messageLabel setHidden:NO];
    }
}

@end
