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
#import <MessageUI/MessageUI.h>


@interface SiteReviewViewController () <MFMailComposeViewControllerDelegate>


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
    [self sendEmailAsCSV];
}

-(void)resetSite{
    
    UINavigationController *infoNavController = (UINavigationController *)[self.tabBarController.viewControllers objectAtIndex:1];
    SiteInfoViewController *siteInfo = (SiteInfoViewController *)[infoNavController.viewControllers firstObject];
    Site *site = [[Site alloc]init];
    [siteInfo setSite:site];
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
    if (self.tree || self.treeStarted) {
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

#pragma mark - Email Client

- (void)mailComposeController:(MFMailComposeViewController *)controller
          didFinishWithResult:(MFMailComposeResult)result
                        error:(NSError *)error {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)sendEmailAsCSV{
    if ( [MFMailComposeViewController canSendMail] )
    {
        MFMailComposeViewController *mailComposer = [[MFMailComposeViewController alloc] init];
        mailComposer.mailComposeDelegate = self;
        
        [mailComposer setMessageBody:@"Hi,\nThis is the data I've collected for the day.\nThank you!" isHTML:NO];
        
        [mailComposer setSubject:[NSString stringWithFormat:@"%@ - %@", self.site.fireNumber, self.site.dtaName]];
        
//        [mailComposer addAttachmentData:[self generateSiteAndTreeDataAsCSV]  mimeType:@"cvs" fileName:[NSString stringWithFormat:@"Insurentory csv"]];
        
        [self presentViewController:mailComposer animated:YES completion:nil];
    }
}
//
//- (NSData *)generateSiteAndTreeDataAsCSV {
//    
//    NSOutputStream *outputStream = [[NSOutputStream alloc] initToMemory];
//    CHCSVWriter *csvWriter = [[CHCSVWriter alloc] initWithOutputStream:outputStream encoding:NSUTF8StringEncoding delimiter:','];
//    
//    [csvWriter writeLineOfFields:@[self.insurentory.name, self.insurentory.timeStamp, self.insurentory.totalValue]];
//    [csvWriter writeLineOfFields:@[ @"Asset Name", @"Asset Value"]];
//    //[csvWriter finishLine];
//    
//    for (Asset *asset in self.insurentory.assets) {
//        //[csvWriter writeLineOfFields: @[asset.name, asset.value]];
//        [csvWriter writeField:asset.name];
//        [csvWriter writeField:asset.value];
//        [csvWriter finishLine];
//    }
//    
//    [csvWriter closeStream];
//    
//    NSData *bufferOutput = [outputStream propertyForKey:NSStreamDataWrittenToMemoryStreamKey];
//    return bufferOutput;
//}





@end
