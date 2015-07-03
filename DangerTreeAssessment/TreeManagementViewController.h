//
//  TreeManagementViewController.h
//  DangerTreeAssessment
//
//  Created by Abegael Jackson on 2015-06-16.
//  Copyright (c) 2015 Abbey Jackson & Alain Kahwaji. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Placeholder;
@class Site;
@class Tree;


@interface TreeManagementViewController : UIViewController


@property (strong, nonatomic) Placeholder *placeholder;
@property (strong, nonatomic) Site *site;
@property (strong, nonatomic) Tree *tree;

@property (assign, nonatomic) BOOL isDangerousSet;


@end
