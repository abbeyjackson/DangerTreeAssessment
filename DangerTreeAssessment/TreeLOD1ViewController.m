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

@interface TreeLOD1ViewController ()
@property (weak, nonatomic) IBOutlet UISegmentedControl *insecureControl;
@property (weak, nonatomic) IBOutlet UISegmentedControl *unstableControl;
@property (weak, nonatomic) IBOutlet UISegmentedControl *leaningControl;

@end

@implementation TreeLOD1ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupSegmentedControls];
    
    self.placeholder = [[Placeholder alloc]init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)setupSegmentedControls{
    self.insecureControl.selectedSegmentIndex = 1;
    self.unstableControl.selectedSegmentIndex = 1;
    self.leaningControl.selectedSegmentIndex = 1;
}

-(IBAction)segmentControlValueChanged:(id)sender {
    UISegmentedControl* control = (UISegmentedControl*)sender;
    NSString *result;
    if(control.selectedSegmentIndex == 0){
        result = @"Safe";
    }
    else if(control.selectedSegmentIndex == 1){
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

-(void)saveLOD1{
    RLMRealm *realm = self.site.realm;
    
    [realm beginWriteTransaction];
    self.tree.insecure = self.placeholder.insecure;
    self.tree.unstable = self.placeholder.unstable;
    self.tree.leaning = self.placeholder.leaning;
    [realm commitWriteTransaction];
}

- (IBAction)saveTreeAssessmentButton:(id)sender {
    [self saveLOD1];
    [self performSegueWithIdentifier:@"showTreeMgt" sender: self];
}


#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([[segue identifier] isEqualToString:@"showTreeMgt"]) {
        [[segue destinationViewController] setTree:self.tree];
        [[segue destinationViewController] setSite:self.site];
    }
}


@end
