//
//  TreeInfoViewController.m
//  DangerTreeAssessment
//
//  Created by Abegael Jackson on 2015-06-16.
//  Copyright (c) 2015 Abbey Jackson & Alain Kahwaji. All rights reserved.
//

#import "TreeInfoViewController.h"

@interface TreeInfoViewController ()<UIActionSheetDelegate>

@property (weak, nonatomic) IBOutlet UITextField *latitudeField;
@property (weak, nonatomic) IBOutlet UITextField *longitudeField;
@property (weak, nonatomic) IBOutlet UITextField *speciesField;
@property (weak, nonatomic) IBOutlet UITextField *classField;
@property (weak, nonatomic) IBOutlet UITextField *wildlifeValueField;

@end

@implementation TreeInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)speciesActionSheet:(id)sender {

}
- (IBAction)classActionSheet:(id)sender {

}
- (IBAction)wildlifeValueActionSheet:(id)sender {
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                             delegate:self
                                                    cancelButtonTitle:@"Select Wildlife Value"
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:@"HIGH", @"MEDIUM", @"LOW", nil];
    
    [actionSheet showInView:self.view];
}
- (IBAction)saveNewTreeButton:(id)sender {

}

- (IBAction)unwindToTreeInfo:(UIStoryboardSegue*)sender{
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
