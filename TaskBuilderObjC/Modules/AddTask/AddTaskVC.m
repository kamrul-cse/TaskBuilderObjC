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
    NSString *error = [viewModel checkError:_nameField.text time:_timeField.text dependency:_dependencyField.text];
    _messageLabel.text = error;
    if (error == NULL) {
        [_messageLabel setHidden:YES];
    } else {
        [_messageLabel setHidden:NO];
    }
}

@end
