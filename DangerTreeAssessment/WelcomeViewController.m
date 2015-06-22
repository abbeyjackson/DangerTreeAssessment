//
//  WelcomeViewController.m
//  DangerTreeAssessment
//
//  Created by Abegael Jackson on 2015-06-16.
//  Copyright (c) 2015 Abbey Jackson & Alain Kahwaji. All rights reserved.
//

#import "WelcomeViewController.h"
#import "SiteInfoViewController.h"

@interface WelcomeViewController ()

@end

@implementation WelcomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)goToDataList:(id)sender {
    [self.tabBarController setSelectedIndex:1];
}

- (IBAction)startNewSite:(id)sender {
    
    UIStoryboard *assessment = [UIStoryboard storyboardWithName:@"Assessment" bundle:nil];
    SiteInfoViewController *destination = [assessment instantiateViewControllerWithIdentifier:@"SiteInformation"];
    [self showViewController:destination sender:self];
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
