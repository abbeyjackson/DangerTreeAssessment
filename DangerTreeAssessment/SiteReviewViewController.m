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
#import "TreeInfoViewController.h"
#import "ReportLabel.h"


@interface SiteReviewViewController () <MFMailComposeViewControllerDelegate, UITableViewDelegate, UITableViewDataSource>{
    NSArray *csvArray;
    NSMutableString *strOutput;
    NSArray *singleTreeArray;
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

@implementation SiteReviewViewController{
    NSArray *siteReviewObjects;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self generateCSVFile];
    NSLog(@"Array: %@", csvArray);
    [self createSiteReportLabelArray];
}

-(void)viewWillAppear:(BOOL)animated{
    [self checkIfSiteExistsAndIsComplete];
}

- (IBAction)submitReport:(id)sender {
    [self checkIfTreeExistsAndIsComplete];
}


-(void)createSiteReportLabelArray{
    ReportLabel *fireNumber = [[ReportLabel alloc] initWithLabel:@"Fire Number" andDetail:self.site.fireNumber];
    ReportLabel *dtaName = [[ReportLabel alloc] initWithLabel:@"DTA Name" andDetail:self.site.dtaName];
    ReportLabel *dtaUnit = [[ReportLabel alloc] initWithLabel:@"DTA Unit" andDetail:self.site.dtaUnit];
    ReportLabel *fuel = [[ReportLabel alloc] initWithLabel:@"Fuel" andDetail:self.site.fuel];
    ReportLabel *location = [[ReportLabel alloc] initWithLabel:@"Location" andDetail:self.site.location];
    ReportLabel *bui = [[ReportLabel alloc] initWithLabel:@"BUI" andDetail:self.site.bui];
    ReportLabel *lod = [[ReportLabel alloc] initWithLabel:@"LOD" andDetail:self.site.lod];
    ReportLabel *activity = [[ReportLabel alloc] initWithLabel:@"Activity" andDetail:self.site.activity];
    
    siteReviewObjects = [[NSArray alloc] initWithObjects:fireNumber, dtaName, dtaUnit, fuel, location, bui, lod, activity, nil];
    
    
}

-(void)checkIfSiteExistsAndIsComplete{
    
    if (self.site == nil) {
        RLMResults *results = [Site allObjects];
        Site *mostRecentSite = [results lastObject];
        
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"MM-dd-yyyy"];
        
        
        if (mostRecentSite) {
            if ([[NSNumber numberWithBool:mostRecentSite.isReportComplete] isEqual:[NSNumber numberWithBool:NO]] && [mostRecentSite.reportDate isEqualToString:[dateFormat stringFromDate:[NSDate date]]]) {
                self.site = mostRecentSite;
            }
            else{
                UIAlertView *noSiteAlert = [[UIAlertView alloc] initWithTitle:@"Ooops!" message:@"No current site" delegate:self cancelButtonTitle:@"View Site List" otherButtonTitles:@"Start New Site", nil];
                noSiteAlert.tag = 0;
                [noSiteAlert show];
            }
        }
        else{
            UIAlertView *noSiteAlert = [[UIAlertView alloc] initWithTitle:@"Ooops!" message:@"No current site" delegate:self cancelButtonTitle:@"View Site List" otherButtonTitles:@"Start New Site", nil];
            noSiteAlert.tag = 0;
            [noSiteAlert show];
        }
    }
}



-(void)checkIfTreeExistsAndIsComplete{
    if (self.tree || self.treeOpen) {
        if (!self.tree.isComplete) {
            UIAlertView *noTreeAlert = [[UIAlertView alloc] initWithTitle:@"Last Tree Open" message:@"Can't submit site report with open tree" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Go To Current Tree", nil];
            noTreeAlert.tag = 1;
            [noTreeAlert show];
        }
    }
    else {
        [self sendEmailWithCSV];
    }
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
    
    NSArray *headingsArray = [NSArray arrayWithObjects: @"Fire Number", @"Site ID", @"Tree ID", @"Latitude", @"Longitude", @"Species", @"Class", @"Wildlife Value", @"Insecure", @"Unstable", @"Recent Lean", @"Hazardous Top", @"Dead Limbs", @"Witches Broom", @"Split Trunk", @"Stem Damage", @"Sloughing Bark", @"Cankers", @"Conks / Mushrooms", @"Tree Lean", @"Root Inspection", @"Rating", @"Is Dangerous", @"Management", @"Comments", nil];
    
    [csvWriter writeLineOfFields:headingsArray];

    RLMArray *treesArray = self.site.trees;
    
    for (Tree *tree in treesArray) {
        
        NSString *fireNumber = tree.site.fireNumber;
        NSString *siteID = tree.site.siteID;
        NSString *treeID = tree.treeID;
        NSString *lat = tree.lat;
        NSString *lon = tree.lon;
        NSString *species = tree.species;
        NSString *treeClass = tree.treeClass;
        NSString *wildLifeValue = tree.wildLifeValue;
        NSString *insecure = tree.insecure;
        NSString *unstable = tree.unstable;
        NSString *leaning = tree.leaning;
        NSString *hazardousTop = tree.hazardousTop;
        NSString *deadLimbs = tree.deadLimbs;
        NSString *witchesBroom = tree.witchesBroom;
        NSString *splitTrunk = tree.splitTrunk;
        NSString *stemDamage = tree.stemDamage;
        NSString *sloughingBark = tree.sloughingBark;
        NSString *cankers = tree.cankers;
        NSString *conksMushrooms = tree.conksMushrooms;
        NSString *treeLean = tree.treeLean;
        NSString *rootInspection = tree.rootInspection;
        NSString *rating = tree.rating;
        NSString *isDangerous;
        if ([[NSNumber numberWithBool:tree.isDangerous] isEqual:[NSNumber numberWithBool:NO]]) {
            isDangerous = @"YES";
        }
        else {
            isDangerous = @"NO";
        }
        NSString *management = tree.management;
        NSString *comments = tree.comments;
        
        singleTreeArray = [[NSArray alloc] initWithObjects: fireNumber, siteID, treeID, lat, lon, species, treeClass, wildLifeValue, insecure, unstable, leaning, hazardousTop, deadLimbs, witchesBroom, splitTrunk, stemDamage, sloughingBark, cankers, conksMushrooms, treeLean, rootInspection, rating, isDangerous, management, comments, nil];
        NSLog(@"%@", [singleTreeArray objectAtIndex:0]);
        [csvWriter writeLineOfFields:singleTreeArray];
    }
    
    
    [csvWriter closeStream];
    
    NSData *bufferOutput = [outputStream propertyForKey:NSStreamDataWrittenToMemoryStreamKey];
    
    return bufferOutput;

}


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
                [self emailSuccessfulAlert];
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

-(void)emailSuccessfulAlert{
    [self markSendReportComplete];
    UIAlertView *successfulAlert = [[UIAlertView alloc] initWithTitle:@"Success!" message:@"Your message was sent" delegate:self cancelButtonTitle:@"View Site List" otherButtonTitles: @"New Site", nil];
    successfulAlert.tag = 2;
    [successfulAlert show];
}

-(void)markSendReportComplete{
    RLMRealm *realm = self.site.realm;
    [realm beginWriteTransaction];
    self.site.isReportComplete = 1;
    [realm commitWriteTransaction];
    [self resetSite];
}

-(void)resetSite{
    UINavigationController *infoNavController = (UINavigationController *)[self.tabBarController.viewControllers objectAtIndex:1];
    SiteInfoViewController *siteInfo = (SiteInfoViewController *)[infoNavController.viewControllers firstObject];
    [siteInfo setIsNewSite:NO];
}


- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    if (alertView.tag == 0) {
        if (buttonIndex == 0) {
            [self.tabBarController setSelectedIndex:0];
        }
        if (buttonIndex == 1) {
            [self resetSite];
            [self.tabBarController setSelectedIndex:1];
        }
    }
    else if (alertView.tag == 1){
        if (buttonIndex == 0) {
            
        }
        if (buttonIndex == 1) {
            [self resetSite];
            [self.tabBarController setSelectedIndex:2];
        }
    }
    else if (alertView.tag == 2){
        if (buttonIndex == 0) {
            [self.tabBarController setSelectedIndex:0];
        }
        if (buttonIndex == 1) {
            [self resetSite];
            [self.tabBarController setSelectedIndex:1];
        }
    }
}

#pragma mark - TableView

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return siteReviewObjects.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    ReportLabel *reportlabel = siteReviewObjects[indexPath.row];
    
    cell.textLabel.text = reportlabel.label;
    
    cell.detailTextLabel.text = reportlabel.detail;
    
    
    return cell;
}



@end
