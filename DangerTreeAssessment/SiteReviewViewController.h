//
//  SiteReviewViewController.h
//  DangerTreeAssessment
//
//  Created by Abegael Jackson on 2015-06-16.
//  Copyright (c) 2015 Abbey Jackson & Alain Kahwaji. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Site;
@class Tree;


@interface SiteReviewViewController : UITableViewController


@property (strong, nonatomic) Site *site;
@property (strong, nonatomic) Tree *tree;

@property (assign, nonatomic) BOOL isTreeOpen;

@property (strong, nonatomic) UIImage *image;


@end
