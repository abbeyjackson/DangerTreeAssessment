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
        self.tree.hazardousTop = NO;
    }
    else if(self.hazardousTopControl.selectedSegmentIndex == 1){
        // nil
        self.tree.hazardousTop = nil;
    }
    else if(self.hazardousTopControl.selectedSegmentIndex == 2){
        // Dangerous
        self.tree.hazardousTop = YES;
    }
    else {
        self.tree.hazardousTop = nil;
    }
}

- (IBAction)deadLimbsControlAction:(id)sender{
    if(self.deadLimbsControl.selectedSegmentIndex == 0){
        // Safe
        self.tree.deadLimbs = NO;
    }
    else if(self.deadLimbsControl.selectedSegmentIndex == 1){
        // nil
        self.tree.deadLimbs = nil;
    }
    else if(self.deadLimbsControl.selectedSegmentIndex == 2){
        // Dangerous
        self.tree.deadLimbs = YES;
    }
    else {
        self.tree.deadLimbs = nil;
    }
}

- (IBAction)witchesBroomControlAction:(id)sender{
    if(self.witchesBroomControl.selectedSegmentIndex == 0){
        // Safe
        self.tree.witchesBroom = NO;
    }
    else if(self.witchesBroomControl.selectedSegmentIndex == 1){
        // nil
        self.tree.witchesBroom = nil;
    }
    else if(self.witchesBroomControl.selectedSegmentIndex == 2){
        // Dangerous
        self.tree.witchesBroom = YES;
    }
    else {
        self.tree.witchesBroom = nil;
    }
}

- (IBAction)splitTrunkControlAction:(id)sender{
    if(self.splitTrunkControl.selectedSegmentIndex == 0){
        // Safe
        self.tree.splitTrunk = NO;
    }
    else if(self.splitTrunkControl.selectedSegmentIndex == 1){
        // nil
        self.tree.splitTrunk = nil;
    }
    else if(self.splitTrunkControl.selectedSegmentIndex == 2){
        // Dangerous
        self.tree.splitTrunk = YES;
    }
    else {
        self.tree.splitTrunk = nil;
    }
}

- (IBAction)stemDamageControlAction:(id)sender{
    if(self.stemDamageControl.selectedSegmentIndex == 0){
        // Safe
        self.tree.stemDamage = NO;
    }
    else if(self.stemDamageControl.selectedSegmentIndex == 1){
        // nil
        self.tree.stemDamage = nil;
    }
    else if(self.stemDamageControl.selectedSegmentIndex == 2){
        // Dangerous
        self.tree.stemDamage = YES;
    }
    else {
        self.tree.stemDamage = nil;
    }
}

- (IBAction)sloughingBarkControlAction:(id)sender{
    if(self.sloughingBarkControl.selectedSegmentIndex == 0){
        // Safe
        self.tree.sloughingBark = NO;
    }
    else if(self.sloughingBarkControl.selectedSegmentIndex == 1){
        // nil
        self.tree.sloughingBark = nil;
    }
    else if(self.sloughingBarkControl.selectedSegmentIndex == 2){
        // Dangerous
        self.tree.sloughingBark = YES;
    }
    else {
        self.tree.sloughingBark = nil;
    }
}

- (IBAction)cankersControlAction:(id)sender{
    if(self.cankersControl.selectedSegmentIndex == 0){
        // Safe
        self.tree.cankers = NO;
    }
    else if(self.cankersControl.selectedSegmentIndex == 1){
        // nil
        self.tree.cankers = nil;
    }
    else if(self.cankersControl.selectedSegmentIndex == 2){
        // Dangerous
        self.tree.cankers = YES;
    }
    else {
        self.tree.cankers = nil;
    }
}

- (IBAction)conksMushroomsControlAction:(id)sender{
    if(self.conksMushroomsControl.selectedSegmentIndex == 0){
        // Safe
        self.tree.conksMushrooms = NO;
    }
    else if(self.conksMushroomsControl.selectedSegmentIndex == 1){
        // nil
        self.tree.conksMushrooms = nil;
    }
    else if(self.conksMushroomsControl.selectedSegmentIndex == 2){
        // Dangerous
        self.tree.conksMushrooms = YES;
    }
    else {
        self.tree.conksMushrooms = nil;
    }
}

- (IBAction)treeLeanControlAction:(id)sender{
    if(self.treeLeanControl.selectedSegmentIndex == 0){
        // Safe
        self.tree.treeLean = NO;
    }
    else if(self.treeLeanControl.selectedSegmentIndex == 1){
        // nil
        self.tree.treeLean = nil;
    }
    else if(self.treeLeanControl.selectedSegmentIndex == 2){
        // Dangerous
        self.tree.treeLean = YES;
    }
    else {
        self.tree.treeLean = nil;
    }
}

- (IBAction)rootInspectionControlAction:(id)sender{
    if(self.rootInspectionControl.selectedSegmentIndex == 0){
        // Safe
        self.tree.rootInspection = NO;
    }
    else if(self.rootInspectionControl.selectedSegmentIndex == 1){
        // nil
        self.tree.rootInspection = nil;
    }
    else if(self.rootInspectionControl.selectedSegmentIndex == 2){
        // Dangerous
        self.tree.rootInspection = YES;
    }
    else {
        self.tree.rootInspection = nil;
    }
}

- (IBAction)saveTreeAssessmentButton:(id)sender {
    [self performSegueWithIdentifier:@"showTreeMgt" sender: self];    
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([[segue identifier] isEqualToString:@"showTreeMgt"]) {
        [[segue destinationViewController] setTree:self.tree];
    }
}

@end
