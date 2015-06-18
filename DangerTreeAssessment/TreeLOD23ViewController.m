//
//  TreeLOD23ViewController.m
//  DangerTreeAssessment
//
//  Created by Abegael Jackson on 2015-06-16.
//  Copyright (c) 2015 Abbey Jackson & Alain Kahwaji. All rights reserved.
//

#import "TreeLOD23ViewController.h"

@interface TreeLOD23ViewController ()

@property (weak, nonatomic) IBOutlet UISegmentedControl *hazardousTopControl;
@property (weak, nonatomic) IBOutlet UISegmentedControl *deadLimbsControl;
@property (weak, nonatomic) IBOutlet UISegmentedControl *witchesBroomControl;
@property (weak, nonatomic) IBOutlet UISegmentedControl *splitTrunkControl;
@property (weak, nonatomic) IBOutlet UISegmentedControl *stemDamageControl;
@property (weak, nonatomic) IBOutlet UISegmentedControl *sloughingBarkControl;
@property (weak, nonatomic) IBOutlet UISegmentedControl *cankersControl;
@property (weak, nonatomic) IBOutlet UISegmentedControl *conksMushroomsControl;
@property (weak, nonatomic) IBOutlet UISegmentedControl *treeLeanControl;
@property (weak, nonatomic) IBOutlet UISegmentedControl *rootInspectionControl;

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
