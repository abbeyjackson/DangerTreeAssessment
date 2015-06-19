//
//  TreeLOD1ViewController.m
//  DangerTreeAssessment
//
//  Created by Abegael Jackson on 2015-06-16.
//  Copyright (c) 2015 Abbey Jackson & Alain Kahwaji. All rights reserved.
//

#import "TreeLOD1ViewController.h"

@interface TreeLOD1ViewController ()
@property (weak, nonatomic) IBOutlet UISegmentedControl *insecureControl;
@property (weak, nonatomic) IBOutlet UISegmentedControl *unstableControl;
@property (weak, nonatomic) IBOutlet UISegmentedControl *leaningControl;

@end

@implementation TreeLOD1ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupSegmentedControls];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)setupSegmentedControls{
    self.insecureControl.selectedSegmentIndex = 1;
    self.unstableControl.selectedSegmentIndex = 1;
    self.leaningControl.selectedSegmentIndex = 1;
}

- (IBAction)insecureControlAction:(id)sender{
    if(self.insecureControl.selectedSegmentIndex == 0){
        // Safe
        self.tree.insecure = NO;
    }
    else if(self.insecureControl.selectedSegmentIndex == 1){
        // nil
        self.tree.insecure = nil;
    }
    else if(self.insecureControl.selectedSegmentIndex == 2){
        // Dangerous
        self.tree.insecure = YES;
    }
    else {
        self.tree.insecure = nil;
    }
}

- (IBAction)unstableControlAction:(id)sender{
    if(self.unstableControl.selectedSegmentIndex == 0){
        // Safe
        self.tree.unstable = NO;
    }
    else if(self.unstableControl.selectedSegmentIndex == 1){
        // nil
        self.tree.unstable = nil;
    }
    else if(self.unstableControl.selectedSegmentIndex == 2){
        // Dangerous
        self.tree.unstable = YES;
    }
    else {
        self.tree.unstable = nil;
    }
}

- (IBAction)leaningControlAction:(id)sender{
    if(self.leaningControl.selectedSegmentIndex == 0){
        // Safe
        self.tree.leaning = NO;
    }
    else if(self.leaningControl.selectedSegmentIndex == 1){
        // nil
        self.tree.leaning = nil;
    }
    else if(self.leaningControl.selectedSegmentIndex == 2){
        // Dangerous
        self.tree.leaning = YES;
    }
    else {
        self.tree.leaning = nil;
    }
}

-(void)saveLOD1{
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
