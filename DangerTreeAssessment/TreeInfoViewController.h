//
//  TreeInfoViewController.h
//  DangerTreeAssessment
//
//  Created by Abegael Jackson on 2015-06-16.
//  Copyright (c) 2015 Abbey Jackson & Alain Kahwaji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Site.h"
#import "Tree.h"
#import "TreeClassCollectionViewController.h"
#import "TreeSpeciesCollectionViewController.h"

@interface TreeInfoViewController : UIViewController <ClassDelegate, SpeciesDelegate, UIActionSheetDelegate>

@property (nonatomic, strong) Site *site;
@property (nonatomic, strong) Tree *tree;


@end
