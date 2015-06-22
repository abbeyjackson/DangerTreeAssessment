//
//  SiteWindowController.m
//  DangerTreeAssessment
//
//  Created by Abegael Jackson on 2015-06-22.
//  Copyright (c) 2015 Abbey Jackson & Alain Kahwaji. All rights reserved.
//

#import "SiteWindowController.h"

@interface SiteWindowController ()

@end

@implementation SiteWindowController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UINavigationController *navigationController = [[UIStoryboard storyboardWithName:@"Review" bundle:nil] instantiateInitialViewController];
    [self addChildViewController:navigationController];
    [navigationController didMoveToParentViewController:self];
    navigationController.view.frame = self.view.bounds;
    [self.view addSubview:navigationController.view];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
