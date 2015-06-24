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
    
}

-(void)viewWillAppear:(BOOL)animated{
    [self checkIfSiteExistsAndIsComplete];
}

- (IBAction)submitReport:(id)sender {
    [self checkIfTreeExistsAndIsComplete];
}

-(void)checkIfSiteExistsAndIsComplete{
    
    if (self.site == nil) {
        RLMResults *results = [Site allObjects];
        Site *mostRecentSite = [results lastObject];
        if (mostRecentSite) {
            if (!mostRecentSite.isReportComplete) {
                self.site = mostRecentSite;
            }
            else{
                UIAlertView *noSiteAlert = [[UIAlertView alloc] initWithTitle:@"Ooops!" message:@"No current site" delegate:self cancelButtonTitle:@"View Site List" otherButtonTitles:@"Start New Site", nil];
                noSiteAlert.tag = 0;
                [noSiteAlert show];
            }
        }
    }
    
    [self configureLabels];
}

-(void)checkIfTreeExistsAndIsComplete{
    if (self.tree) {
        if (!self.tree.isComplete) {
            UIAlertView *noTreeAlert = [[UIAlertView alloc] initWithTitle:@"Ooops!" message:@"Last tree report not complete" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Go To Current Tree", nil];
            noTreeAlert.tag = 1;
            [noTreeAlert show];
        }
    }
    RLMRealm *realm = self.site.realm;
    [realm beginWriteTransaction];
    self.site.isReportComplete = YES;
    [realm commitWriteTransaction];
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    if (alertView.tag == 0) {
        if (buttonIndex == 0) {
            [self.tabBarController setSelectedIndex:0];
        }
        if (buttonIndex == 1) {
            [self.tabBarController setSelectedIndex:1];
        }
    }
    else if (alertView.tag == 1){
        if (buttonIndex == 0) {
            // dismiss alert
        }
        if (buttonIndex == 1) {
            [self.tabBarController setSelectedIndex:2];
        }
    }
}


- (void)configureLabels{
    self.fireNumberLabel.text = self.site.fireNumber;
    self.dtaNameLabel.text = self.site.dtaName;
    self.unitLabel.text = self.site.fuel;
    self.locationLabel.text = self.site.location;
    self.buiLabel.text = self.site.bui;
    self.lodLabel.text = self.site.lod;
    self.activityLabel.text = self.site.activity;
}


@end
