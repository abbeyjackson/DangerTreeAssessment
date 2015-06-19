//
//  SiteInfoViewController.m
//  DangerTreeAssessment
//
//  Created by Abegael Jackson on 2015-06-16.
//  Copyright (c) 2015 Abbey Jackson & Alain Kahwaji. All rights reserved.
//

#import "SiteInfoViewController.h"

@interface SiteInfoViewController ()<UIActionSheetDelegate, UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *fireNumberField;
@property (weak, nonatomic) IBOutlet UITextField *dtaNameField;
@property (weak, nonatomic) IBOutlet UITextField *dtaUnitField;
@property (weak, nonatomic) IBOutlet UITextField *fuelField;
@property (weak, nonatomic) IBOutlet UITextField *locationField;
@property (weak, nonatomic) IBOutlet UITextField *buiField;
@property (weak, nonatomic) IBOutlet UITextField *lodField;
@property (weak, nonatomic) IBOutlet UITextField *activityField;

@property (weak, nonatomic) IBOutlet UIButton *addTreeButton;

@end

@implementation SiteInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureTextFields];
}

-(void)configureTextFields{
    [self textFieldShouldBeginEditing:self.fuelField];
    [self textFieldShouldBeginEditing:self.lodField];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    return NO;
}

- (IBAction)fuelActionSheet:(id)sender {

}

- (IBAction)lodActionSheet:(id)sender {
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                             delegate:self
                                                    cancelButtonTitle:@"Select Level Of Disturbance"
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:@"LOD 1", @"LOD 2/3", @"LOD 4", nil];
    
    [actionSheet showInView:self.view];
}


- (IBAction)unwindToSiteInfo:(UIStoryboardSegue*)sender{
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
