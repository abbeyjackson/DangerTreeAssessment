//
//  TreeManagementViewController.m
//  DangerTreeAssessment
//
//  Created by Abegael Jackson on 2015-06-16.
//  Copyright (c) 2015 Abbey Jackson & Alain Kahwaji. All rights reserved.
//

#import "TreeManagementViewController.h"

#import "Constants.h"
#import "UIColor+CustomColours.h"

#import "Placeholder.h"
#import "Site.h"
#import "Tree.h"
#import "TreeReviewViewController.h"


@interface TreeManagementViewController ()<UIActionSheetDelegate, UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UISegmentedControl *safeDangerousControl;
@property (weak, nonatomic) IBOutlet UITextField *managementField;
@property (weak, nonatomic) IBOutlet UITextView *commentsTextView;

@end


@implementation TreeManagementViewController


#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureTextFields];
    [self setupSegmentedControls];
    [self configureCommentBox];
    self.placeholder = [[Placeholder alloc]init];
    if (self.isDangerousSet) {
        self.placeholder.isDangerous = self.isDangerousSet;
    }
}


#pragma mark - Setup

-(void)setupSegmentedControls{
    if (self.isDangerousSet) {
        self.safeDangerousControl.selectedSegmentIndex = 1;
    }
    else {
        self.safeDangerousControl.selectedSegmentIndex = 0;
    }
}

-(void)configureTextFields{
    self.commentsTextView.delegate = self;
}

-(void)configureCommentBox{
    [self.commentsTextView.layer setBorderColor:[[[UIColor lightGrayColor] colorWithAlphaComponent:0.5] CGColor]];
    [self.commentsTextView.layer setBorderWidth:.6];
    self.commentsTextView.layer.cornerRadius = 5.0;
    self.commentsTextView.clipsToBounds = YES;
    
    self.commentsTextView.text = @"Comments";
    self.commentsTextView.textColor = [UIColor lightGrayColor];
}


#pragma mark - Gestures

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}


#pragma mark - IBActions

- (IBAction)safeDangerousControl:(id)sender{
    if(self.safeDangerousControl.selectedSegmentIndex == 0){
        self.placeholder.isDangerous = 0;
    }
    else if(self.safeDangerousControl.selectedSegmentIndex == 1){
        self.placeholder.isDangerous = 1;
    }
    else {
        self.placeholder.isDangerous = 0;
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

- (IBAction)makeTreeReportButton:(id)sender {
    if ([self.managementField.text isEqual:@""]){
        UIAlertView *fieldsMandatory = [[UIAlertView alloc] initWithTitle:@"Entry Error"
                                                     message:@"Please fill in the management action field."
                                                    delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [fieldsMandatory show];
    }
    else{
        [self saveTreeMgt];
        [self performSegueWithIdentifier:@"showTreeReview" sender:self];
    }
}


#pragma mark - Action Sheet

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


#pragma mark - TextField Delegate

-(void)textViewDidBeginEditing:(UITextView *)textView{
    [UIView animateWithDuration:0.2 animations:^{
        CGRect frameUp = self.view.frame;
        frameUp.origin.y -=140;
        self.view.frame = frameUp;
    }];
    
    if ([textView.text isEqualToString:@"Comments"]) {
        textView.text = @"";
        textView.textColor = [UIColor blackColor];
    }
    [textView becomeFirstResponder];
}

-(void)textViewDidEndEditing:(UITextView *)textView{
    [UIView animateWithDuration:0.2 animations:^{
        self.view.frame = [[UIScreen mainScreen] bounds];
    }];
    
    if ([textView.text isEqualToString:@""]) {
        textView.text = @"Comments";
        textView.textColor = [UIColor lightGrayColor];
    }
    [textView resignFirstResponder];
}


#pragma mark - Save Data

-(void)saveTreeMgt{
    self.tree.isDangerous = self.placeholder.isDangerous;
    self.tree.management = self.managementField.text;
    self.tree.comments = self.commentsTextView.text;
}


#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showTreeReview"]) {
        [[segue destinationViewController] setTree:self.tree];
        [[segue destinationViewController] setSite:self.site];
    }
}


@end
