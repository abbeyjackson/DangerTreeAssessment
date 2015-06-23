//
//  TreeManagementViewController.m
//  DangerTreeAssessment
//
//  Created by Abegael Jackson on 2015-06-16.
//  Copyright (c) 2015 Abbey Jackson & Alain Kahwaji. All rights reserved.
//

#import "TreeManagementViewController.h"
#import "TreeReviewViewController.h"
#import "Tree.h"
#import "Site.h"
#import "Placeholder.h"

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
    self.placeholder = [[Placeholder alloc]init];
}

-(void)setupSegmentedControls{
    self.safeDangerousControl.selectedSegmentIndex = 0;
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
            frameUp.origin.y -=140;
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

- (IBAction)safeDangerousControl:(id)sender{
    if(self.safeDangerousControl.selectedSegmentIndex == 0){
        // Safe
        self.placeholder.isDangerous = NO;
    }
    else if(self.safeDangerousControl.selectedSegmentIndex == 1){
        // Dangerous
        self.placeholder.isDangerous = YES;
    }
    else {
        self.placeholder.isDangerous = NO;
    }
}

- (IBAction)managementActionSheet:(id)sender {
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                             delegate:self
                                                    cancelButtonTitle:@"Select Management Action"
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:kNoAction, kFallTree, kInstallNWZ, kOther, nil];
    
    [actionSheet showInView:self.view];
    
    
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0) {
        self.managementField.text = kNoAction;
    }
    if (buttonIndex == 1) {
        self.managementField.text = kFallTree;
    }
    if (buttonIndex == 2) {
        self.managementField.text = kInstallNWZ;
    }
    if (buttonIndex == 3) {
        self.managementField.text = kOther;
    }
}

-(void)saveTreeMgt{
    self.tree.isDangerous = self.placeholder.isDangerous;
    self.tree.management = self.managementField.text;
    self.tree.comments = self.commentsTextView.text;}

- (IBAction)makeTreeReportButton:(id)sender {
    [self saveTreeMgt];
   
    [self performSegueWithIdentifier:@"showTreeReview" sender:self];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showTreeReview"]) {
        TreeReviewViewController *destination = [[TreeReviewViewController alloc]init];
        [[segue destinationViewController] setTree:self.tree];
        [[segue destinationViewController] setSite:self.site];
    }
}

@end
