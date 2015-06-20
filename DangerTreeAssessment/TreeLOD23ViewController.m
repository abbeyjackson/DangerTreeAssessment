//
//  TreeLOD23ViewController.m
//  DangerTreeAssessment
//
//  Created by Abegael Jackson on 2015-06-16.
//  Copyright (c) 2015 Abbey Jackson & Alain Kahwaji. All rights reserved.
//

#import "TreeLOD23ViewController.h"
#import "Tree.h"
#import "Placeholder.h"

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

-(IBAction)segmentControlValueChanged:(id)sender {
    UISegmentedControl* control = (UISegmentedControl*)sender;
    NSString *result;
    if(control.selectedSegmentIndex == 0){
        result = @"Safe";
    }
    else if(control.selectedSegmentIndex == 1){
        result = nil;
    }
    else if(control.selectedSegmentIndex == 2){
        result = @"Dangerous";
    }
    else {
        result = nil;
    }
    [self setResult:result forSegmentControl:control];
}


-(void)setResult:(NSString*)result forSegmentControl:(UISegmentedControl*)control {
    if (control == self.hazardousTopControl) {
        self.placeholder.hazardousTop = result;
    }
    else if (control == self.deadLimbsControl){
        self.placeholder.deadLimbs = result;
    }
    else if (control == self.witchesBroomControl){
        self.placeholder.witchesBroom = result;
    }
    else if (control == self.splitTrunkControl){
        self.placeholder.splitTrunk = result;
    }
    else if (control == self.stemDamageControl){
        self.placeholder.stemDamage = result;
    }
    else if (control == self.sloughingBarkControl){
        self.placeholder.sloughingBark = result;
    }
    else if (control == self.cankersControl){
        self.placeholder.cankers = result;
    }
    else if (control == self.conksMushroomsControl){
        self.placeholder.conksMushrooms = result;
    }
    else if (control == self.treeLeanControl){
        self.placeholder.treeLean = result;
    }
    else if (control == self.rootInspectionControl){
        self.placeholder.rootInspection = result;
    }
}

-(void)saveLOD23{
    RLMRealm *realm = [RLMRealm defaultRealm];
    
    [realm beginWriteTransaction];
    self.tree.hazardousTop = self.placeholder.hazardousTop;
    self.tree.deadLimbs = self.placeholder.deadLimbs;
    self.tree.witchesBroom = self.placeholder.witchesBroom;
    self.tree.splitTrunk = self.placeholder.splitTrunk;
    self.tree.stemDamage = self.placeholder.stemDamage;
    self.tree.sloughingBark = self.placeholder.sloughingBark;
    self.tree.cankers = self.placeholder.cankers;
    self.tree.conksMushrooms = self.placeholder.conksMushrooms;
    self.tree.treeLean = self.placeholder.treeLean;
    self.tree.rootInspection = self.placeholder.rootInspection;
    [realm commitWriteTransaction];
}


- (IBAction)saveTreeAssessmentButton:(id)sender {
    [self saveLOD23];
    [self performSegueWithIdentifier:@"showTreeMgt" sender: self];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showTreeMgt"]) {
        [[segue destinationViewController] setTree:self.tree];
    }
}


@end

