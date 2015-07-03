//
//  TreeInfoViewController.h
//  DangerTreeAssessment
//
//  Created by Abegael Jackson on 2015-06-16.
//  Copyright (c) 2015 Abbey Jackson & Alain Kahwaji. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "TreeClassCollectionViewController.h"
#import "TreeSpeciesCollectionViewController.h"

@class Site;
@class Tree;


@interface TreeInfoViewController : UIViewController <ClassDelegate, SpeciesDelegate>


@property (strong, nonatomic) Site *lastSite;
@property (strong, nonatomic) Site *site;
@property (strong, nonatomic) Tree *tree;

@property (assign, nonatomic) BOOL isNewTree;


-(void)initializeNewTree;


@end
