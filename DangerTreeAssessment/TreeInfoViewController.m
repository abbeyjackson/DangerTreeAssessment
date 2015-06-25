//
//  TreeInfoViewController.m
//  DangerTreeAssessment
//
//  Created by Abegael Jackson on 2015-06-16.
//  Copyright (c) 2015 Abbey Jackson & Alain Kahwaji. All rights reserved.
//

#import "TreeInfoViewController.h"
#import "TreeLOD1ViewController.h"
#import "TreeLOD23ViewController.h"
#import "TreeLOD4ViewController.h"
#import "TreeClass.h"
#import "TreeSpecies.h"
#import "Tree.h"
#import "Site.h"
#import "SiteInfoViewController.h"
#import "UIColor+CustomColours.h"
#import "DataTableViewController.h"
#import "SiteReviewViewController.h"

@interface TreeInfoViewController (){
    CLLocationManager *locationManager;
}

@property (weak, nonatomic) IBOutlet UITextField *latitudeField;
@property (weak, nonatomic) IBOutlet UITextField *longitudeField;
@property (weak, nonatomic) IBOutlet UITextField *speciesField;
@property (weak, nonatomic) IBOutlet UITextField *classField;
@property (weak, nonatomic) IBOutlet UITextField *wildlifeValueField;

@end

@implementation TreeInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    locationManager = [[CLLocationManager alloc] init];
    
}

-(void)viewWillAppear:(BOOL)animated{
    
    [self checkIfNewTree];
    [self getCurrentLocation];
    self.navigationItem.hidesBackButton = YES;
    
}

-(void)checkIfNewTree{
    if (self.tree) {
        if (self.tree.isComplete) {
            [self initializeNewTree];
            [self configureTextFields];
        }
        else {
            // let user edit current tree
        }
    }
    else if (self.site){
        if (self.site.isReportComplete) {
            // no site, let user choose to make new site or go to site list
            UIAlertView *noCurrentSite = [[UIAlertView alloc] initWithTitle:@"No Open Site" message:@"Can't make new tree without an open site" delegate:self cancelButtonTitle:@"View Site List" otherButtonTitles:@"Make New Site", nil];
            noCurrentSite.tag = 0;
            [noCurrentSite show];
        }
        else {
            // let user continue new tree
        }
    }
    else if (!self.site){
        RLMResults *sites = [Site allObjects];
        Site *site = [sites lastObject];
        if (site){
            if (site.isReportComplete) {
                // no site, let user choose to make new site or go to site list
                UIAlertView *noCurrentSite = [[UIAlertView alloc] initWithTitle:@"No Open Site" message:@"Can't make new tree without an open site" delegate:self cancelButtonTitle:@"View Site List" otherButtonTitles:@"Make New Site", nil];
                noCurrentSite.tag = 0;
                [noCurrentSite show];
            }
            else {
                // last site open, let user choose to add new tree, go to site report or go to site list
                NSString *alertString = [NSString stringWithFormat:@"Do you want to add to %@?", site.siteID];
                UIAlertView *lastSiteOpen = [[UIAlertView alloc] initWithTitle:@"Last Site Still Open" message:alertString delegate:self cancelButtonTitle:@"View Site List" otherButtonTitles:@"Add New Tree", @"Make New Site", nil];
                lastSiteOpen.tag = 1;
                [lastSiteOpen show];
            }
        }
        else {
            // no site, let user choose to make new site or go to site list
            UIAlertView *noCurrentSite = [[UIAlertView alloc] initWithTitle:@"No Open Site" message:@"Can't make new tree without an open site" delegate:self cancelButtonTitle:@"View Site List" otherButtonTitles:@"Make New Site", nil];
            noCurrentSite.tag = 0;
            [noCurrentSite show];
        }
    }
    else {
        // let user make new tree
        [self initializeNewTree];
        [self configureTextFields];
    }
}

-(void)setCurrentSite{
    RLMResults *sites = [Site allObjects];
    Site *site = [sites lastObject];
    self.site = site;
}

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
    }
}

#pragma mark - CLLocationManagerDelegate

- (void)getCurrentLocation{
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [locationManager requestWhenInUseAuthorization];
    
    [locationManager startUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"didFailWithError: %@", error);
    UIAlertView *errorAlert = [[UIAlertView alloc]
                               initWithTitle:@"Error" message:@"Failed to Get Your Location, you will have to enter GPS manually" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [errorAlert show];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    NSLog(@"didUpdateToLocation: %@", newLocation);
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

-(void)initializeNewTree{
    
    self.tree = [[Tree alloc]init];
    
}

-(void)resetSite{
    
    UINavigationController *infoNavController = (UINavigationController *)[self.tabBarController.viewControllers objectAtIndex:1];
    SiteInfoViewController *siteInfo = (SiteInfoViewController *)[infoNavController.viewControllers firstObject];
    [siteInfo initializeNewSite];
}
    
    
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

    return self.tree;
}

-(void)configureTextFields{
    
    self.latitudeField.text = nil;
    self.longitudeField.text = nil;
    self.speciesField.text = nil;
    self.classField.text = nil;
    self.wildlifeValueField.text = nil;
    
    [self textFieldShouldBeginEditing:self.speciesField];
    [self textFieldShouldBeginEditing:self.classField];
    [self textFieldShouldBeginEditing:self.wildlifeValueField];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    return NO;
}


- (IBAction)wildlifeValueActionSheet:(id)sender {
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                             delegate:self
                                                    cancelButtonTitle:@"Select Wildlife Value"
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:kH, kM, kL, nil];
    
    [actionSheet showInView:self.view];
}

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

-(void)selectClass:(TreeClass *)class{
    self.classField.text = class.numAndInfo;
}

-(void)selectSpecies:(TreeSpecies *)species{
    self.speciesField.text = [NSString stringWithFormat:@"%@ - %@", species.abbreviation, species.name];
}


-(void)setTreeIsOpen{
    UINavigationController *reviewNavController = (UINavigationController *)[self.tabBarController.viewControllers objectAtIndex:3];
    SiteReviewViewController *siteReview = (SiteReviewViewController *)[reviewNavController.viewControllers firstObject];
    [siteReview setTreeStarted:YES];
    
    UINavigationController *infoNavController = (UINavigationController *)[self.tabBarController.viewControllers objectAtIndex:1];
    SiteInfoViewController *siteInfo = (SiteInfoViewController *)[infoNavController.viewControllers firstObject];
//    [siteInfo setTreeStarted:YES];
}


- (IBAction)saveNewTreeButton:(id)sender {
    self.tree = [self createTree];
    [self setTreeIsOpen];
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
