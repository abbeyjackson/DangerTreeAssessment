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
#import <CoreLocation/CoreLocation.h>
@class Tree;
@class Site;


@interface TreeInfoViewController : UIViewController <ClassDelegate, SpeciesDelegate, UIActionSheetDelegate,CLLocationManagerDelegate>

@property (nonatomic, strong) Site *site;
@property (nonatomic, strong) Tree *tree;
@property (nonatomic, strong) Site *lastSite;

-(void)initializeNewTree;

@end
