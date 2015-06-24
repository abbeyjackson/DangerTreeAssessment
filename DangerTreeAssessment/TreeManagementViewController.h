//
//  TreeManagementViewController.h
//  DangerTreeAssessment
//
//  Created by Abegael Jackson on 2015-06-16.
//  Copyright (c) 2015 Abbey Jackson & Alain Kahwaji. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Tree;
@class Site;
@class Placeholder;

@interface TreeManagementViewController : UIViewController

@property (nonatomic,strong) Tree *tree;
@property (nonatomic, strong) Site *site;
@property (nonatomic, strong) Placeholder *placeholder;
@property (nonatomic) BOOL isDangerousSet;


@end
