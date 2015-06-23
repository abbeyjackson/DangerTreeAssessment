//
//  TreeWindowController.m
//  DangerTreeAssessment
//
//  Created by Abegael Jackson on 2015-06-22.
//  Copyright (c) 2015 Abbey Jackson & Alain Kahwaji. All rights reserved.
//

#import "TreeWindowController.h"

@interface TreeWindowController ()

@end

@implementation TreeWindowController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UINavigationController *navigationController = [[UIStoryboard storyboardWithName:@"Assessment" bundle:nil] instantiateViewControllerWithIdentifier:@"SiteInformationVC"];
    [self addChildViewController:navigationController];
    [navigationController didMoveToParentViewController:self];
    navigationController.view.frame = self.view.bounds;
    [self.view addSubview:navigationController.view];
}

@end
