//
//  TreeLOD1ViewController.m
//  DangerTreeAssessment
//
//  Created by Abegael Jackson on 2015-06-16.
//  Copyright (c) 2015 Abbey Jackson & Alain Kahwaji. All rights reserved.
//

#import "TreeLOD1ViewController.h"

@interface TreeLOD1ViewController ()

@property (weak, nonatomic) IBOutlet UILabel *insecureLabel;
@property (weak, nonatomic) IBOutlet UILabel *unstableLabel;
@property (weak, nonatomic) IBOutlet UILabel *leaningLabel;

@property (weak, nonatomic) IBOutlet UISwitch *insecureSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *unstableSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *leaningSwitch;
@end

@implementation TreeLOD1ViewController

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
