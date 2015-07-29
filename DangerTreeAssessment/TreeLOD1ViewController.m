//
//  TreeLOD1ViewController.m
//  DangerTreeAssessment
//
//  Created by Abegael Jackson on 2015-06-16.
//  Copyright (c) 2015 Abbey Jackson & Alain Kahwaji. All rights reserved.
//

#import "TreeLOD1ViewController.h"

#import "Constants.h"
#import "UIColor+CustomColours.h"

#import "Placeholder.h"
#import "Site.h"
#import "Tree.h"
#import "TreeInfoViewController.h"
#import "TreeManagementViewController.h"


@interface TreeLOD1ViewController ()

@property (weak, nonatomic) IBOutlet UISegmentedControl *insecureControl;
@property (weak, nonatomic) IBOutlet UISegmentedControl *unstableControl;
@property (weak, nonatomic) IBOutlet UISegmentedControl *leaningControl;

@property (strong, nonatomic) IBOutletCollection(UISegmentedControl) NSArray *allSegmentedControls;

@end


@implementation TreeLOD1ViewController


#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.placeholder = [[Placeholder alloc]init];
    [self setupSegmentedControls];
}


#pragma mark - Setup

-(void)setupSegmentedControls{
    self.insecureControl.selectedSegmentIndex = -1;
    self.placeholder.insecure = @"--";
    self.unstableControl.selectedSegmentIndex = -1;
    self.placeholder.unstable = @"--";
    self.leaningControl.selectedSegmentIndex = -1;
    self.placeholder.leaning = @"--";
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


#pragma mark - Alerts

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        [self.tabBarController setSelectedIndex:0];
    }
    if (buttonIndex == 1) {
        UINavigationController *vc = (UINavigationController*)[[self.tabBarController viewControllers] objectAtIndex:2];
        TreeInfoViewController *destination = vc.viewControllers.firstObject;
        [destination setSite:self.site];
        [self.tabBarController setSelectedIndex:2];
    }
    if (buttonIndex == 2) {
        [self.tabBarController setSelectedIndex:3];
    }
}


#pragma mark - General Methods

-(void)setResult:(NSString*)result forSegmentControl:(UISegmentedControl*)control {
    if (control == self.insecureControl) {
        self.placeholder.insecure = result;
    }
    else if (control == self.unstableControl){
        self.placeholder.unstable = result;
    }
    else if (control == self.leaningControl){
        self.placeholder.leaning = result;
    }
}

-(BOOL)isDangerous{
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
    [self saveLOD1];
    [self performSegueWithIdentifier:@"showTreeMgt" sender: self];
}


#pragma mark - Save Data

-(void)saveLOD1{
    self.tree.insecure = self.placeholder.insecure;
    self.tree.unstable = self.placeholder.unstable;
    self.tree.leaning = self.placeholder.leaning;
}


#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showTreeMgt"]) {
        
        if ([[NSNumber numberWithBool:self.isDangerous] isEqual:[NSNumber numberWithBool:YES]]) {
            [[segue destinationViewController] setIsDangerousSet:1];
        }
        
        [[segue destinationViewController] setTree:self.tree];
        [[segue destinationViewController] setSite:self.site];
    }
}


@end
