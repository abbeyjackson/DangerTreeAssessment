//
//  SiteReviewViewController.h
//  DangerTreeAssessment
//
//  Created by Abegael Jackson on 2015-06-16.
//  Copyright (c) 2015 Abbey Jackson & Alain Kahwaji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constants.h"
@class Tree;
@class Site;

@interface SiteReviewViewController : UITableViewController

@property (nonatomic) Tree *tree;
@property (nonatomic) Site *site;
@property (nonatomic, assign) BOOL treeOpen;

@end
