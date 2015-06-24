//
//  TabBarController.m
//  DangerTreeAssessment
//
//  Created by Abegael Jackson on 2015-06-23.
//  Copyright (c) 2015 Abbey Jackson & Alain Kahwaji. All rights reserved.
//

#import "TabBarController.h"

@implementation TabBarController

-(void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {
    NSUInteger indexOfTab = [[tabBar items] indexOfObject:item];
    
    if (indexOfTab == 0) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            UINavigationController *navControllerForDataListVC = (UINavigationController *)[self.tabBarController.viewControllers firstObject];
            [navControllerForDataListVC popToRootViewControllerAnimated:NO];
        });
        
    }
}

@end
