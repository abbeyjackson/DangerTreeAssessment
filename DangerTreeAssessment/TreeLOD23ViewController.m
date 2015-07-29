//
//  TreeLOD23ViewController.m
//  DangerTreeAssessment
//
//  Created by Abegael Jackson on 2015-06-16.
//  Copyright (c) 2015 Abbey Jackson & Alain Kahwaji. All rights reserved.
//

#import "TreeLOD23ViewController.h"

#import "Constants.h"
#import "UIColor+CustomColours.h"

#import "Placeholder.h"
#import "Site.h"
#import "Tree.h"
#import "TreeManagementViewController.h"


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

@property (strong, nonatomic) IBOutletCollection(UISegmentedControl) NSArray *allSegmentedControls;

@end


@implementation TreeLOD23ViewController


#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.placeholder = [[Placeholder alloc]init];
    [self setupSegmentedControls];
}


#pragma mark - Setup

-(void)setupSegmentedControls{
    self.hazardousTopControl.selectedSegmentIndex = -1;
    self.placeholder.hazardousTop = @"--";
    self.deadLimbsControl.selectedSegmentIndex = -1;
    self.placeholder.deadLimbs = @"--";
    self.witchesBroomControl.selectedSegmentIndex = -1;
    self.placeholder.witchesBroom = @"--";
    self.splitTrunkControl.selectedSegmentIndex = -1;
    self.placeholder.splitTrunk = @"--";
    self.stemDamageControl.selectedSegmentIndex = -1;
    self.placeholder.stemDamage = @"--";
    self.sloughingBarkControl.selectedSegmentIndex = -1;
    self.placeholder.sloughingBark = @"--";
    self.cankersControl.selectedSegmentIndex = -1;
    self.placeholder.cankers = @"--";
    self.conksMushroomsControl.selectedSegmentIndex = -1;
    self.placeholder.conksMushrooms = @"--";
    self.treeLeanControl.selectedSegmentIndex = -1;
    self.placeholder.treeLean = @"--";
    self.rootInspectionControl.selectedSegmentIndex = -1;
    self.placeholder.rootInspection = @"--";
}


#pragma mark - Analysis

-(void)checkIfNewTree{
    if (self.tree) {
        if (self.tree.isComplete) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"No Current Tree" message:@"What would you like to do next?" delegate:self cancelButtonTitle:@"View Site List" otherButtonTitles:@"New Tree", @"Submit Report", nil];
            [alert show];
        }
        else {
            // let user edit current tree
        }
    }
    else {
    }
}


#pragma mark - General Methods

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

-(BOOL)setDangerous{
    for (UISegmentedControl *control in self.allSegmentedControls) {
        if (control.selectedSegmentIndex == 2) {
            return YES;
        }
    }
    return NO;
}


#pragma mark - IBActions

-(IBAction)segmentControlValueChanged:(id)sender {
    UISegmentedControl* control = (UISegmentedControl*)sender;
    NSString *result;
    if(control.selectedSegmentIndex == 0){
        result = @"Safe";
    }
    else if(control.selectedSegmentIndex == 1){
        control.selectedSegmentIndex = -1;
        result = @"-";
    }
    else if(control.selectedSegmentIndex == 2){
        result = @"Dangerous";
    }
    else {
        result = nil;
    }
    [self setResult:result forSegmentControl:control];
}

- (IBAction)saveTreeAssessmentButton:(id)sender {
    [self saveLOD23];
    [self performSegueWithIdentifier:@"showTreeMgt" sender: self];
}


#pragma mark - Save Data

-(void)saveLOD23{
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
}


#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showTreeMgt"]) {
        if ([self setDangerous]) {
            [[segue destinationViewController] setIsDangerousSet:1];
        }
        [[segue destinationViewController] setTree:self.tree];
        [[segue destinationViewController] setSite:self.site];
    }
}


@end

