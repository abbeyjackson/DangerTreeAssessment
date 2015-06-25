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
#import "Tree.h"
#import <MessageUI/MessageUI.h>
#import "CHCSVParser.h"


@interface SiteReviewViewController () <MFMailComposeViewControllerDelegate>{
    NSArray *csvArray;
    NSMutableString *strOutput;
}


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
    [self generateCSVFile];
    NSLog(@"Array: %@", csvArray);
}

-(void)viewWillAppear:(BOOL)animated{
    [self checkIfSiteExistsAndIsComplete];
}

- (IBAction)submitReport:(id)sender {
    [self checkIfTreeExistsAndIsComplete];
    [self sendEmailWithCSV];
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

- (void)sendEmailWithCSV{
    if ( [MFMailComposeViewController canSendMail] )
    {
        MFMailComposeViewController *mailComposer = [[MFMailComposeViewController alloc] init];
        mailComposer.mailComposeDelegate = self;
        
        NSString *messageBodyString = [NSString stringWithFormat:@"Report Date: %@\nFire Number: %@\nSite Location: %@\nSite ID: %@\nDTA Name: %@\nDTA Unit: %@\nNumber Of Trees: %lu\nFuel: %@\nBUI: %@\nLOD: %@\nActivity: %@\n", self.site.reportDate, self.site.fireNumber, self.site.location, self.site.siteID, self.site.dtaName, self.site.dtaUnit, (unsigned long)self.site.trees.count, self.site.fuel, self.site.bui, self.site.lod, self.site.activity];
        
        [mailComposer setMessageBody:messageBodyString isHTML:NO];
        
        [mailComposer setSubject:[NSString stringWithFormat:@"%@ - %@", self.site.fireNumber, self.site.dtaName]];
        
        
        NSString *reportNameString = [NSString stringWithFormat:@"SiteReport-%@-%@.csv",self.site.reportDate, self.site.formattedDtaID];
        [mailComposer addAttachmentData:[self generateCSVFile]  mimeType:@"cvs" fileName:reportNameString];
        
        [self presentViewController:mailComposer animated:YES completion:nil];
    }
}


-(NSData *)generateCSVFile{
    
    NSOutputStream *outputStream = [[NSOutputStream alloc] initToMemory];
    
    
    CHCSVWriter *csvWriter = [[CHCSVWriter alloc] initWithOutputStream:outputStream encoding:NSUTF8StringEncoding delimiter:','];
    
//    [[CHCSVWriter alloc]initForWritingToCSVFile:[NSHomeDirectory() stringByAppendingPathComponent:reportNameString]];
    
    
    NSArray *headingsArray = [NSArray arrayWithObjects: @"Fire Number", @"Site ID", @"Tree ID", @"Latitude", @"Longitude", @"Species", @"Class", @"Wildlife Value", @"Insecure", @"Unstable", @"Recent Lean", @"Hazardous Top", @"Dead Limbs", @"Witches Broom", @"Split Trunk", @"Stem Damage", @"Sloughing Bark", @"Cankers", @"Conks / Mushrooms", @"Tree Lean", @"Root Inspection", @"Rating", @"Is Dangerous", @"Management", @"Comments", nil];
    
    [csvWriter writeLineOfFields:headingsArray];

    RLMArray *treesArray = self.site.trees;
    
    for (Tree *tree in treesArray) {
        
        NSArray *singleTreeArray = [NSArray arrayWithObjects: tree.site.fireNumber, tree.site.siteID, tree.treeID, tree.lat, tree.lon, tree.species, tree.treeClass, tree.wildLifeValue, tree.insecure, tree.unstable, tree.leaning, tree.hazardousTop, tree.deadLimbs, tree.witchesBroom, tree.splitTrunk, tree.stemDamage, tree.sloughingBark, tree.cankers, tree.conksMushrooms, tree.treeLean, tree.rootInspection, tree.rating, tree.isDangerous, tree.management, tree.comments, nil];
        
        [csvWriter writeLineOfFields:singleTreeArray];
    }
    
    
    [csvWriter closeStream];
    
    NSData *bufferOutput = [outputStream propertyForKey:NSStreamDataWrittenToMemoryStreamKey];
    
    return bufferOutput;

}


//-(void)generateCsvFile{
//
//    NSString *csvString = [csvArray componentsJoinedByString:@","];
//    NSLog(@"csvString:%@",csvString);
//    
//    // Create .csv file and save in Documents Directory.
//    
//    //create instance of NSFileManager
//    NSFileManager *fileManager = [NSFileManager defaultManager];
//    
//    //create an array and store result of our search for the documents directory in it
//    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//    
//    //create NSString object, that holds our exact path to the documents directory
//    NSString *documentsDirectory = [paths objectAtIndex:0];
//    NSLog(@"Document Dir: %@",documentsDirectory);
//    
//    NSString *fullPath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.csv", @"userdata"]]; //add our file to the path
//    [fileManager createFileAtPath:fullPath contents:[csvString dataUsingEncoding:NSUTF8StringEncoding] attributes:nil]; //finally save the path (file)
//}



# pragma mark - If pressed cancel

-(void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error{
    
    //if result is possible
    if(result == MFMailComposeResultSent || result == MFMailComposeResultSaved || result == MFMailComposeResultCancelled){
        
        //test result and show alert
        switch (result) {
            case MFMailComposeResultCancelled:
                [self emailNotSuccessfulAlert];
                break;
            case MFMailComposeResultSaved:
                [self emailNotSuccessfulAlert];
                break;
                //message was sent
            case MFMailComposeResultSent:
                [self markSendReportComplete];
                break;
            case MFMailComposeResultFailed:
                [self emailNotSuccessfulAlert];
                break;
            default:
                break;
        }
    }
    //else exists error
    else if(error != nil){
        [self emailNotSuccessfulAlert];
    }
    
    //dismiss view
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)emailNotSuccessfulAlert{
    UIAlertView *submitUnsuccessfulAlert = [[UIAlertView alloc] initWithTitle:@"Message not sent!" message:@"" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
    submitUnsuccessfulAlert.tag = 3;
    [submitUnsuccessfulAlert show];
}

-(void)markSendReportComplete{
    RLMRealm *realm = self.site.realm;
    [realm beginWriteTransaction];
    self.site.isReportComplete = YES;
    [realm commitWriteTransaction];
}




@end
