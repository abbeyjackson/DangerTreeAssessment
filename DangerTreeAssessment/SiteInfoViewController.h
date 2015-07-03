//
//  SiteInfoViewController.h
//  DangerTreeAssessment
//
//  Created by Abegael Jackson on 2015-06-16.
//  Copyright (c) 2015 Abbey Jackson & Alain Kahwaji. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Site;


@interface SiteInfoViewController : UIViewController


@property (strong, nonatomic) Site *site;

@property (assign, nonatomic) BOOL isNewSite;
@property (assign, nonatomic) BOOL isNewTree;

@property (weak, nonatomic) IBOutlet UITextField *lodField;


-(void)initializeNewSite;


@end
