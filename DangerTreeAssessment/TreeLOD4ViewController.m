//
//  TreeLOD4ViewController.m
//  DangerTreeAssessment
//
//  Created by Abegael Jackson on 2015-06-16.
//  Copyright (c) 2015 Abbey Jackson & Alain Kahwaji. All rights reserved.
//

#import "TreeLOD4ViewController.h"

@interface TreeLOD4ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *ratingField;

@end

@implementation TreeLOD4ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)ratingActionSheet:(id)sender {
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                             delegate:self
                                                    cancelButtonTitle:@"Select Rating"
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:@"Dangerous", @"Class 1 Trees = S", @"Class 2 Trees With No Structural Defects = S", @"Class 2 Cedars With Low Failure Potential = S", @"Class 3 Conifers With No Structural Defects = S", nil];
    
    [actionSheet showInView:self.view];
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
