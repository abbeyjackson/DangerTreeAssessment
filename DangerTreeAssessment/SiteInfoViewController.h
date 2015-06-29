//
//  SiteInfoViewController.h
//  DangerTreeAssessment
//
//  Created by Abegael Jackson on 2015-06-16.
//  Copyright (c) 2015 Abbey Jackson & Alain Kahwaji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Site.h"
#import "FuelCollectionViewController.h"
#import "Constants.h"

@interface SiteInfoViewController : UIViewController <FuelDelegate, UIActionSheetDelegate, UITextFieldDelegate, UINavigationControllerDelegate>

@property (nonatomic, strong) Site *site;
@property (nonatomic, assign) BOOL isNewSite;
@property (weak, nonatomic) IBOutlet UITextField *lodField;
@property (nonatomic, assign) BOOL isNewTree;

-(void)initializeNewSite;

@end
