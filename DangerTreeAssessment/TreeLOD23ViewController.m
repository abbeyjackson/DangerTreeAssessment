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
    [self setupSegmentedControls];
}

-(void)setupSegmentedControls{
    self.hazardousTopControl.selectedSegmentIndex = 1;
    self.deadLimbsControl.selectedSegmentIndex = 1;
    self.witchesBroomControl.selectedSegmentIndex = 1;
    self.splitTrunkControl.selectedSegmentIndex = 1;
    self.stemDamageControl.selectedSegmentIndex = 1;
    self.sloughingBarkControl.selectedSegmentIndex = 1;
    self.cankersControl.selectedSegmentIndex = 1;
    self.conksMushroomsControl.selectedSegmentIndex = 1;
    self.treeLeanControl.selectedSegmentIndex = 1;
    self.rootInspectionControl.selectedSegmentIndex = 1;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)hazardousTopControlAction:(id)sender{
    if(self.hazardousTopControl.selectedSegmentIndex == 0){
        // Safe
    }
    else if(self.hazardousTopControl.selectedSegmentIndex == 1){
        // nil
    }
    else if(self.hazardousTopControl.selectedSegmentIndex == 2){
        // Dangerous
    }
}

- (IBAction)deadLimbsControlAction:(id)sender{
    if(self.deadLimbsControl.selectedSegmentIndex == 0){
        // Safe
    }
    else if(self.deadLimbsControl.selectedSegmentIndex == 1){
        // nil
    }
    else if(self.deadLimbsControl.selectedSegmentIndex == 2){
        // Dangerous
    }
}

- (IBAction)witchesBroomControlAction:(id)sender{
    if(self.witchesBroomControl.selectedSegmentIndex == 0){
        // Safe
    }
    else if(self.witchesBroomControl.selectedSegmentIndex == 1){
        // nil
    }
    else if(self.witchesBroomControl.selectedSegmentIndex == 2){
        // Dangerous
    }
}

- (IBAction)splitTrunkControlAction:(id)sender{
    if(self.splitTrunkControl.selectedSegmentIndex == 0){
        // Safe
    }
    else if(self.splitTrunkControl.selectedSegmentIndex == 1){
        // nil
    }
    else if(self.splitTrunkControl.selectedSegmentIndex == 2){
        // Dangerous
    }
}

- (IBAction)stemDamageControlAction:(id)sender{
    if(self.stemDamageControl.selectedSegmentIndex == 0){
        // Safe
    }
    else if(self.stemDamageControl.selectedSegmentIndex == 1){
        // nil
    }
    else if(self.stemDamageControl.selectedSegmentIndex == 2){
        // Dangerous
    }
}

- (IBAction)sloughingBarkControlAction:(id)sender{
    if(self.sloughingBarkControl.selectedSegmentIndex == 0){
        // Safe
    }
    else if(self.sloughingBarkControl.selectedSegmentIndex == 1){
        // nil
    }
    else if(self.sloughingBarkControl.selectedSegmentIndex == 2){
        // Dangerous
    }
}

- (IBAction)cankersControlAction:(id)sender{
    if(self.cankersControl.selectedSegmentIndex == 0){
        // Safe
    }
    else if(self.cankersControl.selectedSegmentIndex == 1){
        // nil
    }
    else if(self.cankersControl.selectedSegmentIndex == 2){
        // Dangerous
    }
}

- (IBAction)conksMushroomsControlAction:(id)sender{
    if(self.conksMushroomsControl.selectedSegmentIndex == 0){
        // Safe
    }
    else if(self.conksMushroomsControl.selectedSegmentIndex == 1){
        // nil
    }
    else if(self.conksMushroomsControl.selectedSegmentIndex == 2){
        // Dangerous
    }
}

- (IBAction)treeLeanControlAction:(id)sender{
    if(self.treeLeanControl.selectedSegmentIndex == 0){
        // Safe
    }
    else if(self.treeLeanControl.selectedSegmentIndex == 1){
        // nil
    }
    else if(self.treeLeanControl.selectedSegmentIndex == 2){
        // Dangerous
    }
}

- (IBAction)rootInspectionControlAction:(id)sender{
    if(self.rootInspectionControl.selectedSegmentIndex == 0){
        // Safe
    }
    else if(self.rootInspectionControl.selectedSegmentIndex == 1){
        // nil
    }
    else if(self.rootInspectionControl.selectedSegmentIndex == 2){
        // Dangerous
    }
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
