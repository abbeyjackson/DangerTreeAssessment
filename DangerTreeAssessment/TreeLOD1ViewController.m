//
//  TreeLOD1ViewController.m
//  DangerTreeAssessment
//
//  Created by Abegael Jackson on 2015-06-16.
//  Copyright (c) 2015 Abbey Jackson & Alain Kahwaji. All rights reserved.
//

#import "TreeLOD1ViewController.h"
#import "Placeholder.h"
#import "Tree.h"
#import "Site.h"
#import "UIColor+CustomColours.h"
#import "TreeManagementViewController.h"

@interface TreeLOD1ViewController ()
@property (weak, nonatomic) IBOutlet UISegmentedControl *insecureControl;
@property (weak, nonatomic) IBOutlet UISegmentedControl *unstableControl;
@property (weak, nonatomic) IBOutlet UISegmentedControl *leaningControl;
@property (strong, nonatomic) IBOutletCollection(UISegmentedControl) NSArray *allSegmentedControls;

@end

@implementation TreeLOD1ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.placeholder = [[Placeholder alloc]init];
    [self setupSegmentedControls];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)setupSegmentedControls{
    
    self.insecureControl.selectedSegmentIndex = -1;
    self.placeholder.insecure = @"--";
    self.unstableControl.selectedSegmentIndex = -1;
    self.placeholder.unstable = @"--";
    self.leaningControl.selectedSegmentIndex = -1;
    self.placeholder.leaning = @"--";
}

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

-(void)saveLOD1{
    self.tree.insecure = self.placeholder.insecure;
    self.tree.unstable = self.placeholder.unstable;
    self.tree.leaning = self.placeholder.leaning;
}

- (IBAction)saveTreeAssessmentButton:(id)sender {
    [self saveLOD1];
    [self performSegueWithIdentifier:@"showTreeMgt" sender: self];
}


#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([[segue identifier] isEqualToString:@"showTreeMgt"]) {
        if ([self isDangerous]) {
            [[segue destinationViewController] setIsDangerousSet:YES];
        }
        [[segue destinationViewController] setTree:self.tree];
        [[segue destinationViewController] setSite:self.site];
    }
}


@end
