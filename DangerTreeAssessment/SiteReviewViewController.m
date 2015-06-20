//
//  SiteReviewViewController.m
//  DangerTreeAssessment
//
//  Created by Abegael Jackson on 2015-06-16.
//  Copyright (c) 2015 Abbey Jackson & Alain Kahwaji. All rights reserved.
//

#import "SiteReviewViewController.h"
#import "SiteInfoViewController.h"
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
    // Do any additional setup after loading the view.
    [self displayLabels];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)displayLabels{
    RLMResults *results = [Site allObjects];
//    NSLog(@"All objects in Realm are:%@", results);

    Site *site = [results objectAtIndex:1];
//    NSLog(@"FireNumber: %@", site.fireNumber);
    
    self.fireNumberLabel.text = site.fireNumber;
    self.dtaNameLabel.text = site.dtaName;
    self.unitLabel.text = site.fuel;
    self.locationLabel.text = site.location;
    self.buiLabel.text = site.bui;
    self.lodLabel.text = site.lod;
    self.activityLabel.text = site.activity;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
