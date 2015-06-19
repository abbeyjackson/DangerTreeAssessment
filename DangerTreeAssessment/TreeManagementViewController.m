//
//  TreeManagementViewController.m
//  DangerTreeAssessment
//
//  Created by Abegael Jackson on 2015-06-16.
//  Copyright (c) 2015 Abbey Jackson & Alain Kahwaji. All rights reserved.
//

#import "TreeManagementViewController.h"

@interface TreeManagementViewController ()<UIActionSheetDelegate, UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UISegmentedControl *safeDangerousControl;
@property (weak, nonatomic) IBOutlet UITextField *managementField;
@property (weak, nonatomic) IBOutlet UITextView *commentsTextView;

@end

@implementation TreeManagementViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureTextFields];
    [self setupSegmentedControls];
}

-(void)setupSegmentedControls{
    self.safeDangerousControl.selectedSegmentIndex = 1;
}
    
-(void)configureTextFields{
    self.commentsTextView.delegate = self;
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

#pragma TextField Delegate


-(void)textViewDidBeginEditing:(UITextView *)textView{
    [UIView animateWithDuration:0.2 animations:^{
            CGRect frameUp = self.view.frame;
            frameUp.origin.y -=240;
            self.view.frame = frameUp;
    }];
}


-(void)textViewDidEndEditing:(UITextView *)textView{
    [UIView animateWithDuration:0.2 animations:^{
        self.view.frame = [[UIScreen mainScreen] bounds];
    }];
    
    [textView resignFirstResponder];
}


-(void)configureCommentBox{
    [self.commentsTextView.layer setBorderColor:[[[UIColor lightGrayColor] colorWithAlphaComponent:0.5] CGColor]];
    [self.commentsTextView.layer setBorderWidth:.6];
    self.commentsTextView.layer.cornerRadius = 5.0;
    self.commentsTextView.clipsToBounds = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)safeDangerousControlAction:(id)sender{
    if(self.safeDangerousControl.selectedSegmentIndex == 0){
        // Safe
    }
    else if(self.safeDangerousControl.selectedSegmentIndex == 1){
        // nil
    }
}

- (IBAction)managementActionSheet:(id)sender {
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                             delegate:self
                                                    cancelButtonTitle:@"Select Management Action"
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:@"Safe - No Action Required", @"Dangerous - Fall Tree", @"Dangerous - Install NWZ", @"Other - Remove Hazard", nil];
    
    [actionSheet showInView:self.view];
}
- (IBAction)makeTreeReportButton:(id)sender {
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
