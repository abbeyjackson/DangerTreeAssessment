//
//  SiteInfoViewController.m
//  DangerTreeAssessment
//
//  Created by Abegael Jackson on 2015-06-16.
//  Copyright (c) 2015 Abbey Jackson & Alain Kahwaji. All rights reserved.
//

#import "SiteInfoViewController.h"

#import "Constants.h"
#import "UIColor+CustomColours.h"

#import "Fuel.h"
#import "FuelCollectionViewController.h"
#import "Site.h"
#import "SiteReviewViewController.h"
#import "TreeInfoViewController.h"

#import <CoreLocation/CoreLocation.h>


@interface SiteInfoViewController () <CLLocationManagerDelegate, FuelDelegate, UIActionSheetDelegate, UINavigationControllerDelegate, UITextFieldDelegate>{
    
    CLLocationManager *locationManager;
    CLLocation *currentLocation;
    
}


@property (weak, nonatomic) IBOutlet UITextField *fireNumberField;
@property (weak, nonatomic) IBOutlet UITextField *dtaNameField;
@property (weak, nonatomic) IBOutlet UITextField *dtaUnitField;
@property (weak, nonatomic) IBOutlet UITextField *fuelField;
@property (weak, nonatomic) IBOutlet UITextField *locationField;
@property (weak, nonatomic) IBOutlet UITextField *buiField;
@property (weak, nonatomic) IBOutlet UITextField *activityField;

@property (strong, nonatomic) NSDateFormatter *dateFormat;
@property (strong, nonatomic) NSDateFormatter *reportDateFormat;

@property (strong, nonatomic) NSString *dtaID;


@end


@implementation SiteInfoViewController


#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureDateFormats];
    locationManager = [[CLLocationManager alloc] init];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self checkIfNewSite];
    [self getCurrentLocation];
}


#pragma mark - Setup

-(void)configureDateFormats{
    self.dateFormat = [[NSDateFormatter alloc] init];
    [self.dateFormat setDateFormat:@"yyMMdd"];
    
    self.reportDateFormat = [[NSDateFormatter alloc] init];
    [self.reportDateFormat setDateFormat:@"MM-dd-yyyy"];
}

-(void)configureTextFields{
    self.locationField.delegate = self;
    self.buiField.delegate = self;
    self.activityField.delegate = self;
    
    self.fireNumberField.text = nil;
    self.dtaNameField.text = nil;
    self.dtaUnitField.text = nil;
    self.fuelField.text = nil;
    self.locationField.text = nil;
    self.buiField.text = nil;
    self.lodField.text = nil;
    self.activityField.text = nil;
}

-(void)initializeNewSite{
    self.site = [[Site alloc]init];
    self.isNewSite = YES;
}


#pragma mark - Analysis

-(void)checkIfNewSite{
    if (self.site) {
        if ([[NSNumber numberWithBool:self.site.isReportComplete] isEqual:[NSNumber numberWithBool:YES]]) {
            // let user make new site
            [self initializeNewSite];
            [self configureTextFields];
        }
        else if (self.isNewSite == YES){
            // let user continue current site
            if (self.isNewTree){
                UIAlertView *lastTreeOpen = [[UIAlertView alloc] initWithTitle:@"Current Tree Open" message:@"Can not start new site" delegate:self cancelButtonTitle: kViewSiteList otherButtonTitles: kGoToTree, kSubmitSiteReport, nil];
                lastTreeOpen.tag = 1;
                [lastTreeOpen show];
            }
        }
        else {
            // user should close site before making a new one or can add new tree
            UIAlertView *currentSiteOpen = [[UIAlertView alloc] initWithTitle:@"Current Site Still Open" message:@"Should submit site before making new one" delegate:self cancelButtonTitle: kViewSiteList otherButtonTitles:kSubmitSiteReport, kStartNewSite, kAddNewTree, nil];
            currentSiteOpen.tag = 0;
            [currentSiteOpen show];
        }
    }
    else {
        RLMResults *sites = [Site allObjects];
        Site *mostRecentsite = [sites lastObject];
        if (mostRecentsite) {
            if ([[NSNumber numberWithBool:mostRecentsite.isReportComplete] isEqual:[NSNumber numberWithBool:NO]]) {
                // user should close site before making a new one or can add new tree
                UIAlertView *lastSiteOpen = [[UIAlertView alloc] initWithTitle:@"Last Site Still Open" message:@"Should submit site before making new one" delegate:self cancelButtonTitle: kViewSiteList otherButtonTitles: kSubmitSiteReport, kStartNewSite, kAddNewTree, nil];
                lastSiteOpen.tag = 0;
                [lastSiteOpen show];
            }
            else {
                // let user make new site
                [self initializeNewSite];
                [self configureTextFields];
            }
        }
        else {
            // let user make new site
            [self initializeNewSite];
            [self configureTextFields];
        }
    }
}


#pragma mark - Alerts

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    if (alertView.tag == 0){
        // currentSiteOpen & lastSiteOpen
        if (buttonIndex == 0) {
            [self.tabBarController setSelectedIndex:0];
        }
        if (buttonIndex == 1) {
            [self.tabBarController setSelectedIndex:3];
        }
        if (buttonIndex == 2) {
            [self initializeNewSite];
            [self configureTextFields];
            [self.tabBarController setSelectedIndex:1];
        }
        if (buttonIndex == 3) {
            [self.tabBarController setSelectedIndex:2];
        }
    }
    if (alertView.tag == 1){
        // lastTreeOpen
        if (buttonIndex == 0) {
            [self.tabBarController setSelectedIndex:0];
        }
        if (buttonIndex == 1) {
            [self.tabBarController setSelectedIndex:2];
        }
        if (buttonIndex == 2) {
            [self.tabBarController setSelectedIndex:3];
        }
    }
    if (alertView.tag == 2){
        // fieldsMandatory
        if (buttonIndex == 0){
            [self.tabBarController setSelectedIndex:1];
        }
    }
}


#pragma mark - Gestures

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}


#pragma mark - Action Sheet

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0) {
        self.lodField.text = kLODType1;
    }
    if (buttonIndex == 1) {
        self.lodField.text = kLODType23;
    }
    if (buttonIndex == 2) {
        self.lodField.text = kLODType4;
    }
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


#pragma mark - TextField Delegate

-(void)textFieldDidBeginEditing:(UITextField *)textField{
    [UIView animateWithDuration:0.2 animations:^{
        if (textField == self.locationField || textField == self.buiField) {
            CGRect frameUp = self.view.frame;
            frameUp.origin.y -=120;
            self.view.frame = frameUp;
        }
        if (textField == self.activityField) {
            CGRect frameUp = self.view.frame;
            frameUp.origin.y -=240;
            self.view.frame = frameUp;
        }
    }];
}

-(void)textFieldDidEndEditing:(UITextField *)textField{
    [UIView animateWithDuration:0.2 animations:^{
        self.view.frame = [[UIScreen mainScreen] bounds];
    }];
    [textField resignFirstResponder];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}


#pragma mark - Fuel Delegate

-(void)selectFuelType:(Fuel *)fuel{
    self.fuelField.text = [NSString stringWithFormat:@"%@ - %@", fuel.abbreviation, fuel.name];
}


#pragma mark - IBActions

- (IBAction)lodActionSheet:(id)sender {
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                             delegate:self
                                                    cancelButtonTitle:@"Select Level Of Disturbance"
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:kLODType1, kLODType23, kLODType4, nil];
    [actionSheet showInView:self.view];
}

- (IBAction)addNewTree:(id)sender {
    if ([self.fireNumberField.text isEqual:@""] || [self.dtaNameField.text isEqual:@""] || [self.dtaUnitField.text isEqual:@""] || [self.fuelField.text isEqual:@""] || [self.locationField.text isEqual:@""] || [self.buiField.text isEqual:@""] || [self.activityField.text isEqual:@""]){
        
        UIAlertView *fieldsMandatory = [[UIAlertView alloc] initWithTitle:@"Entry Error"
                                                          message:@"Please fill in all fields."
                                                         delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        fieldsMandatory.tag = 2;
        [fieldsMandatory show];
        
    }
    else{
        UINavigationController *vc = (UINavigationController*)[[self.tabBarController viewControllers] objectAtIndex:2];
        self.site = [self createSite];
        TreeInfoViewController *destination = vc.viewControllers.firstObject;
        [destination setSite:self.site];
        [self.tabBarController setSelectedIndex:2];
        
        UINavigationController *navController = (UINavigationController *)[self.tabBarController.viewControllers objectAtIndex:3];
        SiteReviewViewController *siteReview = (SiteReviewViewController *)[navController.viewControllers firstObject];
        [siteReview setSite:self.site];
    }
    
}


#pragma mark - Save Data

-(void)makeDtaID{
    NSString *firstString = [[self.dtaNameField.text substringWithRange:NSMakeRange(0, 3)]stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *secondString = [[self.dtaNameField.text substringFromIndex: [self.dtaNameField.text length]- 3]stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    self.dtaID = [[NSString stringWithFormat:@"%@%@", firstString, secondString ] uppercaseString];
}

-(int)setSiteNumberForArray{
    RLMResults *results = [Site allObjects];
    int number;
    if (results.count > 0){
        Site *site = [results lastObject];
        number = site.numberForArray + 1;
        return number;
    }
    else {
        return 1;
    }
}

-(NSString*)setSiteId{
    NSString *dateString = [self.dateFormat stringFromDate:[NSDate date]];
    [self makeDtaID];
    NSString *newSiteID = [NSString stringWithFormat:@"%@%@01", dateString, self.dtaID];
    NSString *currentDateAndDtaID = [NSString stringWithFormat:@"%@%@",dateString, self.dtaID];
    
    RLMResults *results = [Site allObjects];
    if (results.count > 0) {
        Site *site = [results lastObject];
        NSString *lastSiteID = [NSString stringWithFormat:@"%@",site.siteID];
        NSString *lastDateAndDtaID = [lastSiteID substringWithRange:NSMakeRange(0, 12)];
        
        if ([lastDateAndDtaID isEqualToString:currentDateAndDtaID]) {
            NSString *lastIDNum = [lastSiteID substringFromIndex:[lastSiteID length] - 2];
            int newID = [lastIDNum intValue] + 1;
            if (newID < 10) {
                // make ID two digits
                newSiteID = [NSString stringWithFormat:@"%@%@%02d", dateString, self.dtaID, newID];
            }
            else {
                newSiteID = [NSString stringWithFormat:@"%@%@%d", dateString, self.dtaID, newID];
            }
        }
        else {
            // If a different date or DTA find last report by DTA
            NSString *pred = [NSString stringWithFormat:@"formattedDtaID = '%@'",self.dtaID];
            RLMResults *newDtaResults = [Site objectsWhere:pred];
            site = [newDtaResults lastObject];
            
            if (newDtaResults.count > 0) {
                lastSiteID = [NSString stringWithFormat:@"%@",site.siteID];
                NSString *lastDate = [lastSiteID substringWithRange:NSMakeRange(0, 6)];
                
                // Check date to begin new day and count or continue count if same day
                if ([lastDate isEqualToString:dateString]) {
                    NSString *lastIDNum = [lastSiteID substringFromIndex:[lastSiteID length] - 2];
                    int newID = [lastIDNum intValue] + 1;
                    if (newID < 10) {
                        newSiteID = [NSString stringWithFormat:@"%@%@%02d", dateString, self.dtaID, newID];
                    }
                    else {
                        newSiteID = [NSString stringWithFormat:@"%@%@%d", dateString, self.dtaID, newID];
                    }
                }
            }
            // else no previous report by DTA, first instance with site number 01 will be used
        }
    }
    return newSiteID;
}

-(Site*)createSite{
    self.site.fireNumber = self.fireNumberField.text;
    self.site.dtaName = self.dtaNameField.text;
    self.site.dtaUnit = self.dtaUnitField.text;
    self.site.fuel = [self.fuelField.text substringToIndex:3];
    self.site.location = self.locationField.text;
    self.site.bui = self.buiField.text;
    self.site.lod = self.lodField.text;
    self.site.activity = self.activityField.text;
    self.site.siteID = [self setSiteId];
    self.site.formattedDtaID = self.dtaID;
    self.site.reportDate = [self.reportDateFormat stringFromDate:[NSDate date]];
    self.site.numberForArray = [self setSiteNumberForArray];
    self.site.isReportComplete = 0;
    self.site.commencementLat = [NSString stringWithFormat:@"%f", currentLocation.coordinate.latitude];
    self.site.commencementLon = [NSString stringWithFormat:@"%f", currentLocation.coordinate.longitude];
    
    RLMRealm *realm = [RLMRealm defaultRealm];
    
    [realm beginWriteTransaction];
    [realm addObject:self.site];
    [realm commitWriteTransaction];
    
    self.isNewSite = NO;
    
    return self.site;
}


#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showFuel"]) {
        [[segue destinationViewController] setDelegate:self];
    }
    
}

- (IBAction)unwindToSiteInfo:(UIStoryboardSegue*)sender{
}


@end
