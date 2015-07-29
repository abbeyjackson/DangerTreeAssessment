//
//  SiteReviewViewController.m
//  DangerTreeAssessment
//
//  Created by Abegael Jackson on 2015-06-16.
//  Copyright (c) 2015 Abbey Jackson & Alain Kahwaji. All rights reserved.
//

#import "SiteReviewViewController.h"

#import "Constants.h"
#import "UIColor+CustomColours.h"

#import "CHCSVParser.h"
#import "ReportLabel.h"
#import "Site.h"
#import "SiteInfoViewController.h"
#import "Tree.h"
#import "TreeInfoViewController.h"

#import <CoreLocation/CoreLocation.h>
#import <MessageUI/MessageUI.h>


@interface SiteReviewViewController () <CLLocationManagerDelegate, MFMailComposeViewControllerDelegate, UITableViewDataSource, UITableViewDelegate>{
    
    CLLocationManager *locationManager;
    CLLocation *currentLocation;
    
}

@property (strong, nonatomic) NSArray *csvArray;
@property (strong, nonatomic) NSArray *singleTreeArray;
@property (strong, nonatomic) NSArray *siteReviewObjects;
@property (strong, nonatomic) NSMutableString *strOutput;

@end


@implementation SiteReviewViewController


#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.separatorColor = [UIColor clearColor];
    locationManager = [[CLLocationManager alloc] init];}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self checkIfSiteExistsAndSendEmail];
    [self.tableView setContentInset:UIEdgeInsetsMake(25,0,0,0)];
    [self createSiteReportLabelArray];
    [self.tableView reloadData];
}


#pragma mark - Setup

-(void)createSiteReportLabelArray{
    ReportLabel *fireNumber = [[ReportLabel alloc] initWithLabel:@"Fire Number" andDetail:self.site.fireNumber];
    ReportLabel *dtaName = [[ReportLabel alloc] initWithLabel:@"DTA Name" andDetail:self.site.dtaName];
    ReportLabel *dtaCallSign = [[ReportLabel alloc] initWithLabel:@"DTA Call Sign" andDetail:self.site.dtaCallSign];
    ReportLabel *fuel = [[ReportLabel alloc] initWithLabel:@"Fuel" andDetail:self.site.fuel];
    ReportLabel *location = [[ReportLabel alloc] initWithLabel:@"Location" andDetail:self.site.location];
    ReportLabel *bui = [[ReportLabel alloc] initWithLabel:@"BUI" andDetail:self.site.bui];
    ReportLabel *lod = [[ReportLabel alloc] initWithLabel:@"LOD" andDetail:self.site.lod];
    ReportLabel *activity = [[ReportLabel alloc] initWithLabel:@"Activity" andDetail:self.site.activity];
    
    self.siteReviewObjects = [[NSArray alloc] initWithObjects:fireNumber, dtaName, dtaCallSign, fuel, location, bui, lod, activity, nil];
}


#pragma mark - Analysis

-(void)checkIfTreeExistsAndIsComplete{
    if (self.tree || self.isTreeOpen) {
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

-(void)checkIfSiteExistsAndSendEmail{
    
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


#pragma mark - Alerts

-(void)emailNotSuccessfulAlert{
    UIAlertView *submitUnsuccessfulAlert = [[UIAlertView alloc] initWithTitle:@"Message not sent!" message:@"" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [submitUnsuccessfulAlert show];
}

-(void)emailSuccessfulAlert{
    [self markSendReportComplete];
    UIAlertView *successfulAlert = [[UIAlertView alloc] initWithTitle:@"Success!" message:@"Your message was sent" delegate:self cancelButtonTitle:@"View Site List" otherButtonTitles: @"New Site", nil];
    successfulAlert.tag = 2;
    [successfulAlert show];
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    if (alertView.tag == 0) {
        if (buttonIndex == 0) {
            // noSiteAlert
            [self.tabBarController setSelectedIndex:0];
        }
        if (buttonIndex == 1) {
            [self resetSite];
            [self.tabBarController setSelectedIndex:1];
        }
    }
    else if (alertView.tag == 1){
        // noTreeAlert
        if (buttonIndex == 0) {
            
        }
        if (buttonIndex == 1) {
            [self resetSite];
            [self.tabBarController setSelectedIndex:2];
        }
    }
    else if (alertView.tag == 2){
        // successfulAlert
        if (buttonIndex == 0) {
            [self.tabBarController setSelectedIndex:0];
        }
        if (buttonIndex == 1) {
            [self resetSite];
            [self.tabBarController setSelectedIndex:1];
        }
    }
}


#pragma mark - General Methods

-(NSData *)generateCSVFile{
    NSOutputStream *outputStream = [[NSOutputStream alloc] initToMemory];
    CHCSVWriter *csvWriter = [[CHCSVWriter alloc] initWithOutputStream:outputStream encoding:NSUTF8StringEncoding delimiter:','];
    NSArray *headingsArray = [NSArray arrayWithObjects: @"Fire-Number", @"Site-ID", @"Tree-ID", @"Latitude", @"Longitude", @"Species", @"Class", @"Wildlife-Value", @"Insecure", @"Unstable", @"Recent-Lean", @"Hazardous-Top", @"Dead-Limbs", @"Witches-Broom", @"Split-Trunk", @"Stem-Damage", @"Sloughing-Bark", @"Cankers", @"Conks/Mushrooms", @"Tree-Lean", @"Root-Inspection", @"Rating", @"Is-Dangerous", @"Management", @"Comments", nil];
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
        self.singleTreeArray = [[NSArray alloc] initWithObjects: fireNumber, siteID, treeID, lat, lon, species, treeClass, wildLifeValue, insecure, unstable, leaning, hazardousTop, deadLimbs, witchesBroom, splitTrunk, stemDamage, sloughingBark, cankers, conksMushrooms, treeLean, rootInspection, rating, isDangerous, management, comments, nil];
        [csvWriter writeLineOfFields:self.singleTreeArray];
    }
    [csvWriter closeStream];
    NSData *bufferOutput = [outputStream propertyForKey:NSStreamDataWrittenToMemoryStreamKey];
    return bufferOutput;
}


#pragma mark - IBActions

- (IBAction)submitReport:(id)sender {
    [self checkIfTreeExistsAndIsComplete];
}


#pragma mark - CLLocation Manager

- (void)getCurrentLocation{
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [locationManager requestWhenInUseAuthorization];
    [locationManager startUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation{
    currentLocation = newLocation;
}


#pragma mark - Email Client

- (void)sendEmailWithCSV{
    if ( [MFMailComposeViewController canSendMail] ){
        MFMailComposeViewController *mailComposer = [[MFMailComposeViewController alloc] init];
        mailComposer.mailComposeDelegate = self;
                
        NSString *messageBodyString = [NSString stringWithFormat:@"Report Date: %@\nFire Number: %@\nSite Location: %@\nCommencement Latitude: %@\nCommencement Longitude: %@\nTermination-Latitude: %f,\nTermination-Longitude: %f\nSite-ID: %@\nDTA Name: %@\nDTA Call Sign: %@\nNumber Of Trees: %lu\nFuel: %@\nBUI: %@\nLOD: %@\nActivity: %@\n", self.site.reportDate, self.site.fireNumber, self.site.location, self.site.commencementLat, self.site.commencementLon, currentLocation.coordinate.latitude, currentLocation.coordinate.longitude, self.site.siteID, self.site.dtaName, self.site.dtaCallSign, (unsigned long)self.site.trees.count, self.site.fuel, self.site.bui, self.site.lod, self.site.activity];
        
        [mailComposer setMessageBody:messageBodyString isHTML:NO];
        [mailComposer setSubject:[NSString stringWithFormat:@"%@ - %@", self.site.fireNumber, self.site.dtaName]];
        NSString *reportNameString = [NSString stringWithFormat:@"SiteReport-%@-%@.csv",self.site.reportDate, self.site.formattedDtaID];
        [mailComposer addAttachmentData:[self generateCSVFile]  mimeType:@"cvs" fileName:reportNameString];
        
        [self presentViewController:mailComposer animated:YES completion:nil];
    }
}

-(void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error{
    if(result == MFMailComposeResultSent || result == MFMailComposeResultSaved || result == MFMailComposeResultCancelled){
        switch (result) {
            case MFMailComposeResultCancelled:
                [self emailNotSuccessfulAlert];
                break;
            case MFMailComposeResultSaved:
                [self emailNotSuccessfulAlert];
                break;
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
    else if(error != nil){
        [self emailNotSuccessfulAlert];
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - TableView

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.siteReviewObjects.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    ReportLabel *reportlabel = self.siteReviewObjects[indexPath.row];
    cell.textLabel.text = reportlabel.label;
    cell.detailTextLabel.text = reportlabel.detail;
    return cell;
}


#pragma mark - Save Data

-(void)markSendReportComplete{
    
    RLMRealm *realm = self.site.realm;
    [realm beginWriteTransaction];
    self.site.isReportComplete = 1;
    self.site.terminationLat = [NSString stringWithFormat:@"%f", currentLocation.coordinate.latitude];
    self.site.terminationLon = [NSString stringWithFormat:@"%f", currentLocation.coordinate.longitude];
    [realm commitWriteTransaction];
    [self resetSite];
}


#pragma mark - Pass Data

-(void)resetSite{
    UINavigationController *infoNavController = (UINavigationController *)[self.tabBarController.viewControllers objectAtIndex:1];
    SiteInfoViewController *siteInfo = (SiteInfoViewController *)[infoNavController.viewControllers firstObject];
    [siteInfo setIsNewSite:NO];
}



@end
