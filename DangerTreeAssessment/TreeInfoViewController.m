//
//  TreeInfoViewController.m
//  DangerTreeAssessment
//
//  Created by Abegael Jackson on 2015-06-16.
//  Copyright (c) 2015 Abbey Jackson & Alain Kahwaji. All rights reserved.
//

#import "TreeInfoViewController.h"

#import "Constants.h"
#import "UIColor+CustomColours.h"

#import "Site.h"
#import "SiteInfoViewController.h"
#import "SiteReviewViewController.h"
#import "Tree.h"
#import "TreeClass.h"
#import "TreeLOD1ViewController.h"
#import "TreeLOD23ViewController.h"
#import "TreeLOD4ViewController.h"
#import "TreeSpecies.h"

#import <CoreLocation/CoreLocation.h>


@interface TreeInfoViewController ()<CLLocationManagerDelegate, UIActionSheetDelegate>{
    
    CLLocationManager *locationManager;
    
}

@property (weak, nonatomic) IBOutlet UITextField *latitudeField;
@property (weak, nonatomic) IBOutlet UITextField *longitudeField;
@property (weak, nonatomic) IBOutlet UITextField *speciesField;
@property (weak, nonatomic) IBOutlet UITextField *classField;
@property (weak, nonatomic) IBOutlet UITextField *wildlifeValueField;
@property (weak, nonatomic) IBOutlet UILabel *siteLocationLabel;

@end


@implementation TreeInfoViewController


#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    locationManager = [[CLLocationManager alloc] init];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self checkIfNewTree];
    [self getCurrentLocation];
    self.navigationItem.hidesBackButton = YES;
}


#pragma mark - Setup

-(void)configureTextFields{
    self.latitudeField.text = nil;
    self.longitudeField.text = nil;
    self.speciesField.text = nil;
    self.classField.text = nil;
    self.wildlifeValueField.text = nil;
    
    [self textFieldShouldBeginEditing:self.speciesField];
    [self textFieldShouldBeginEditing:self.classField];
    [self textFieldShouldBeginEditing:self.wildlifeValueField];
    
    [self setTitleLabel];
}

-(void)setTitleLabel{
    self.siteLocationLabel.text = [NSString stringWithFormat:@"Site: %@", self.site.location];
}

-(void)setCurrentSite{
    RLMResults *sites = [Site allObjects];
    Site *site = [sites lastObject];
    self.site = site;
    self.tree.site = self.site;
    [self setTitleLabel];
}

-(void)initializeNewTree{
    self.tree = [[Tree alloc]init];
    self.isNewTree = YES;
}


#pragma mark - Analysis

-(void)checkIfNewTree{
    if (self.tree) {
        if (self.tree.isComplete) {
            [self initializeNewTree];
            [self configureTextFields];
        }
        else {
            if (self.isNewTree == YES) {
                // let user edit current tree
                self.tree.site = self.site;
                [self setTitleLabel];
            }
            else {
                [self initializeNewTree];
                [self configureTextFields];
            }
        }
    }
    else if (self.site){
        if ([[NSNumber numberWithBool:self.site.isReportComplete] isEqual:[NSNumber numberWithBool:YES]]) {
            // no site, let user choose to make new site or go to site list
            UIAlertView *noCurrentSite = [[UIAlertView alloc] initWithTitle:@"No Open Site" message:@"Can't make new tree without an open site" delegate:self cancelButtonTitle: kViewSiteList otherButtonTitles:kStartNewSite, nil];
            noCurrentSite.tag = 0;
            [noCurrentSite show];
        }
        else if ([[NSNumber numberWithBool:self.site.isReportComplete] isEqual:[NSNumber numberWithBool:NO]]) {
            // let user continue new tree
            NSLog(@"got to this point");
            [self initializeNewTree];
            [self configureTextFields];
        }
    }
    else if (!self.site){
        RLMResults *sites = [Site allObjects];
        Site *mostRecentSite = [sites lastObject];
        
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"MM-dd-yyyy"];
        
        if (mostRecentSite){
            if ([[NSNumber numberWithBool:mostRecentSite.isReportComplete] isEqual:[NSNumber numberWithBool:YES]]) {
                // no site, let user choose to make new site or go to site list
                UIAlertView *noCurrentSite = [[UIAlertView alloc] initWithTitle:@"No Open Site" message:@"Can't make new tree without an open site" delegate:self cancelButtonTitle: kViewSiteList otherButtonTitles: kStartNewSite, nil];
                noCurrentSite.tag = 0;
                [noCurrentSite show];
            }
            else if ([mostRecentSite.reportDate isEqualToString:[dateFormat stringFromDate:[NSDate date]]]){
                // last site open, let user choose to add new tree, go to site report or go to site list
                NSString *alertString = [NSString stringWithFormat:@"Do you want to add to %@?", mostRecentSite.location];
                UIAlertView *lastSiteOpen = [[UIAlertView alloc] initWithTitle:@"Last Site Still Open" message:alertString delegate:self cancelButtonTitle: kViewSiteList otherButtonTitles: kAddNewTree, kStartNewSite, kSubmitSiteReport, nil];
                lastSiteOpen.tag = 1;
                [lastSiteOpen show];
            }
            else {
                // no site, let user choose to make new site or go to site list
                UIAlertView *noCurrentSite = [[UIAlertView alloc] initWithTitle:@"No Open Site" message:@"Can't make new tree without an open site" delegate:self cancelButtonTitle: kViewSiteList otherButtonTitles: kAddNewTree, nil];
                noCurrentSite.tag = 0;
                [noCurrentSite show];
            }
        }
        else {
            // no site, let user choose to make new site or go to site list
            UIAlertView *noCurrentSite = [[UIAlertView alloc] initWithTitle:@"No Open Site" message:@"Can't make new tree without an open site" delegate:self cancelButtonTitle: kViewSiteList otherButtonTitles: kStartNewSite, nil];
            noCurrentSite.tag = 0;
            [noCurrentSite show];
        }
    }
}


#pragma mark - Alerts

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    if (alertView.tag == 0){
        if (buttonIndex == 0) {
            [self.tabBarController setSelectedIndex:0];
        }
        if (buttonIndex == 1) {
            [self.tabBarController setSelectedIndex:1];
        }
    }
    if (alertView.tag == 1){
        if (buttonIndex == 0) {
            [self.tabBarController setSelectedIndex:0];
        }
        if (buttonIndex == 1) {
            [self initializeNewTree];
            [self setCurrentSite];
            [self.tabBarController setSelectedIndex:2];
        }
        if (buttonIndex == 2) {
            [self.tabBarController setSelectedIndex:1];
        }
        if (buttonIndex == 3) {
            [self.tabBarController setSelectedIndex:3];
        }
    }if (alertView.tag == 2){
        if (buttonIndex == 0){
            [self.tabBarController setSelectedIndex:2];
        }
    }
}


#pragma mark - Gestures

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}


#pragma mark - CLLocation Manager

- (void)getCurrentLocation{
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [locationManager requestWhenInUseAuthorization];
    [locationManager startUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    UIAlertView *errorAlert = [[UIAlertView alloc]
                               initWithTitle:@"Error" message:@"Failed to Get Your Location, you will have to enter GPS manually" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [errorAlert show];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation{
    CLLocation *currentLocation = newLocation;
    
    if (currentLocation != nil) {
        if ([self.latitudeField.text isEqualToString:@""]) {
            self.latitudeField.text = [NSString stringWithFormat:@"%.8f", currentLocation.coordinate.latitude];
        }
        if ([self.longitudeField.text isEqualToString:@""]) {
            self.longitudeField.text = [NSString stringWithFormat:@"%.8f", currentLocation.coordinate.longitude];
        }
        if (![self.latitudeField.text isEqualToString:@""] && ![self.longitudeField.text isEqualToString:@""]) {
            [locationManager stopUpdatingLocation];
        }
    }
}


#pragma mark - IBActions

- (IBAction)wildlifeValueActionSheet:(id)sender {
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                             delegate:self
                                                    cancelButtonTitle:@"Select Wildlife Value"
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:kH, kM, kL, nil];
    [actionSheet showInView:self.view];
}

- (IBAction)saveNewTreeButton:(id)sender {
    
    if ([self.latitudeField.text isEqual:@""] || [self.longitudeField.text isEqual:@""] || [self.speciesField.text isEqual:@""] || [self.classField.text isEqual:@""] || [self.wildlifeValueField.text isEqual:@""]){
        UIAlertView *fieldsMandatory = [[UIAlertView alloc] initWithTitle:@"Entry Error"
                                                                  message:@"Please fill in all fields."
                                                                 delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        fieldsMandatory.tag = 2;
        [fieldsMandatory show];
    }
    else{
        self.tree = [self createTree];
        if ([self.site.lod isEqualToString: kLODType1]) {
            TreeLOD1ViewController *destination = [self.storyboard instantiateViewControllerWithIdentifier:@"TreeLOD1"];
            [destination setTree:self.tree];
            [destination setSite:self.site];
            [self.navigationController pushViewController:destination animated:YES];
        }
        if ([self.site.lod isEqualToString: kLODType23]) {
            TreeLOD23ViewController *destination =  [self.storyboard instantiateViewControllerWithIdentifier:@"TreeLOD23"];
            [destination setTree:self.tree];
            [destination setSite:self.site];
            [self.navigationController pushViewController:destination animated:YES];
        }
        if ([self.site.lod isEqualToString: kLODType4]) {
            TreeLOD4ViewController *destination = [self.storyboard instantiateViewControllerWithIdentifier:@"TreeLOD4"];
            [destination setTree:self.tree];
            [destination setSite:self.site];
            [self.navigationController pushViewController:destination animated:YES];
        }
    }
}


#pragma mark - Action Sheet

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0) {
        self.wildlifeValueField.text = kH;
    }
    if (buttonIndex == 1) {
        self.wildlifeValueField.text = kM;
    }
    if (buttonIndex == 2) {
        self.wildlifeValueField.text = kL;
    }
}


#pragma mark - Class and Species Delegates

-(void)selectClass:(TreeClass *)class{
    self.classField.text = class.numAndInfo;
}

-(void)selectSpecies:(TreeSpecies *)species{
    self.speciesField.text = [NSString stringWithFormat:@"%@ - %@", species.abbreviation, species.name];
}


#pragma mark - TextField Delegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    return NO;
}


#pragma mark - Save Data

-(NSString*)setTreeNum{
    RLMResults *results = [Tree allObjects];
    Tree *tree = [results lastObject];
    NSString *newTreeNum = @"001";
    if (results.count > 0) {
        if ([tree.site.siteID isEqualToString:self.site.siteID]) {
            int newTreeNumber = [[tree.treeID substringFromIndex:[tree.treeID length] -3] intValue] + 1;
            newTreeNum = [NSString stringWithFormat:@"%03d", newTreeNumber];
        }
        // else newTreeID should be 001
    }
    return newTreeNum;
}

-(Tree*)createTree{
    self.tree.site = self.site;
    self.tree.lat = self.latitudeField.text;
    self.tree.lon = self.longitudeField.text;
    self.tree.species = [self.speciesField.text substringToIndex:3];
    self.tree.treeClass = [self.classField.text substringToIndex:3];
    self.tree.wildLifeValue = self.wildlifeValueField.text;
    self.tree.treeNumber = [self setTreeNum];
    self.tree.treeID = [NSString stringWithFormat:@"%@-%@", self.site.siteID,self.tree.treeNumber];
    
    [self tellSiteAboutTree];
    
    return self.tree;
}


#pragma mark - Pass Data

-(void)tellSiteAboutTree{
    UINavigationController *infoNavController = (UINavigationController *)[self.tabBarController.viewControllers objectAtIndex:1];
    SiteInfoViewController *siteInfo = (SiteInfoViewController *)[infoNavController.viewControllers firstObject];
    [siteInfo setIsNewTree:YES];
    
    UINavigationController *reviewNavController = (UINavigationController *)[self.tabBarController.viewControllers objectAtIndex:3];
    SiteReviewViewController *siteReview = (SiteReviewViewController *)[reviewNavController.viewControllers firstObject];
    [siteReview setIsTreeOpen:YES];
}

-(void)resetSite{
    UINavigationController *infoNavController = (UINavigationController *)[self.tabBarController.viewControllers objectAtIndex:1];
    SiteInfoViewController *siteInfo = (SiteInfoViewController *)[infoNavController.viewControllers firstObject];
    [siteInfo initializeNewSite];
}


#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showSpecies"]) {
        [[segue destinationViewController] setDelegate:self];
    }
    if ([[segue identifier] isEqualToString:@"showClass"]) {
        [[segue destinationViewController] setDelegate:self];
    }
}


- (IBAction)unwindToTreeInfo:(UIStoryboardSegue*)sender{
}


@end
