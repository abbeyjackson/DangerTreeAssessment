//
//  TreeReviewViewController.h
//  DangerTreeAssessment
//
//  Created by Abegael Jackson on 2015-06-16.
//  Copyright (c) 2015 Abbey Jackson & Alain Kahwaji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constants.h"
@class Tree;
@class Site;

@interface TreeReviewViewController : UIViewController

@property (nonatomic,strong) Tree *tree;
@property (nonatomic, strong) Site *site;



@end
