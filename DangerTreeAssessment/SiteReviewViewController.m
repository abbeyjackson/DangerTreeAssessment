//
//  SiteReviewViewController.m
//  DangerTreeAssessment
//
//  Created by Abegael Jackson on 2015-06-16.
//  Copyright (c) 2015 Abbey Jackson & Alain Kahwaji. All rights reserved.
//

#import "SiteReviewViewController.h"
#import "SiteInfoViewController.h"
#import "UIColor+CustomColours.h"
#import "Site.h"

@interface SiteReviewViewController ()

@property (weak, nonatomic) IBOutlet UILabel *fireNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *dtaNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *unitLabel;
@property (weak, nonatomic) IBOutlet UILabel *fuelLabel;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
@property (weak, nonatomic) IBOutlet UILabel *buiLabel;
@property (weak, nonatomic) IBOutlet UILabel *lodLabel;
@property (weak, nonatomic) IBOutlet UILabel *activityLabel;

@end

@implementation SiteReviewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self displayLabels];
}

-(void)viewWillAppear:(BOOL)animated{
    [self checkIfSiteExists];
}

-(void)checkIfSiteExists{
    
    if (self.site == nil) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Ooops!" message:@"No current site" delegate:self cancelButtonTitle:@"View Site List" otherButtonTitles:@"Start New Site", nil];
        
        [alert show];
    }
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        [self.tabBarController setSelectedIndex:0];
    }
    if (buttonIndex == 1) {
        UINavigationController *navigationController = (UINavigationController*)[[self.tabBarController viewControllers] objectAtIndex:0];
        SiteInfoViewController *destination = [navigationController.viewControllers firstObject];
        [destination performSegueWithIdentifier:@"addSite" sender:self];
        [self.tabBarController setSelectedIndex:0];
    }
    
}

- (void)displayLabels{
    self.fireNumberLabel.text = self.site.fireNumber;
    self.dtaNameLabel.text = self.site.dtaName;
    self.unitLabel.text = self.site.fuel;
    self.locationLabel.text = self.site.location;
    self.buiLabel.text = self.site.bui;
    self.lodLabel.text = self.site.lod;
    self.activityLabel.text = self.site.activity;
}


@end
