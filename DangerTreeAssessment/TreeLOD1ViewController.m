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

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)insecureControlAction:(id)sender{
    if(self.insecureControl.selectedSegmentIndex == 0){
        // Safe
    }
    else if(self.insecureControl.selectedSegmentIndex == 1){
        // nil
    }
    else if(self.insecureControl.selectedSegmentIndex == 2){
        // Dangerous
    }
}

- (IBAction)unstableControlAction:(id)sender{
    if(self.unstableControl.selectedSegmentIndex == 0){
        // Safe
    }
    else if(self.unstableControl.selectedSegmentIndex == 1){
        // nil
    }
    else if(self.unstableControl.selectedSegmentIndex == 2){
        // Dangerous
    }
}

- (IBAction)leaningControlAction:(id)sender{
    if(self.leaningControl.selectedSegmentIndex == 0){
        // Safe
    }
    else if(self.leaningControl.selectedSegmentIndex == 1){
        // nil
    }
    else if(self.leaningControl.selectedSegmentIndex == 2){
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
