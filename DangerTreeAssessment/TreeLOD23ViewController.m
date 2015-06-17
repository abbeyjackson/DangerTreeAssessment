//
//  TreeLOD23ViewController.m
//  DangerTreeAssessment
//
//  Created by Abegael Jackson on 2015-06-16.
//  Copyright (c) 2015 Abbey Jackson & Alain Kahwaji. All rights reserved.
//

#import "TreeLOD23ViewController.h"

@interface TreeLOD23ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *hazardousTopLabel;
@property (weak, nonatomic) IBOutlet UILabel *deadLimbsLabel;
@property (weak, nonatomic) IBOutlet UILabel *witchesBroomLabel;
@property (weak, nonatomic) IBOutlet UILabel *splitTrunkLabel;
@property (weak, nonatomic) IBOutlet UILabel *stemDamageLabel;
@property (weak, nonatomic) IBOutlet UILabel *sloughingBarkLabel;
@property (weak, nonatomic) IBOutlet UILabel *cankersLabel;
@property (weak, nonatomic) IBOutlet UILabel *conksMushroomsLabel;
@property (weak, nonatomic) IBOutlet UILabel *treeLeanLabel;
@property (weak, nonatomic) IBOutlet UILabel *rootInspectionLabel;

@property (weak, nonatomic) IBOutlet UISwitch *hazardousTopSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *deadLimbsSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *witchesBroomSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *splitTrunkSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *stemDamageSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *sloughingBarkSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *cankersSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *conksMushroomsSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *treeLeanSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *rootInspectionSwitch;

@end

@implementation TreeLOD23ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)saveTreeAssessmentButton:(id)sender {
    
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
