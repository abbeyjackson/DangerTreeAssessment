//
//  TabBarController.m
//  DangerTreeAssessment
//
//  Created by Abegael Jackson on 2015-06-23.
//  Copyright (c) 2015 Abbey Jackson & Alain Kahwaji. All rights reserved.
//

#import "TabBarController.h"

@implementation TabBarController

-(void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item{
    if (self.tabBarController.selectedIndex == 0) {
        [self.navigationController popToRootViewControllerAnimated:NO];
    }
}

@end
