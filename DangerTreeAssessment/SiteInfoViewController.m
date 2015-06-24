//
//  SiteInfoViewController.m
//  DangerTreeAssessment
//
//  Created by Abegael Jackson on 2015-06-16.
//  Copyright (c) 2015 Abbey Jackson & Alain Kahwaji. All rights reserved.
//

#import "SiteInfoViewController.h"
#import "Site.h"
#import "TreeInfoViewController.h"
#import "Fuel.h"
#import "UIColor+CustomColours.h"
#import "SiteReviewViewController.h"

@interface SiteInfoViewController ()

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

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureDateFormats];
}

-(void)configureDateFormats{
    
    self.dateFormat = [[NSDateFormatter alloc] init];
    [self.dateFormat setDateFormat:@"yyMMdd"];
    
    
    self.reportDateFormat = [[NSDateFormatter alloc] init];
    [self.reportDateFormat setDateFormat:@"MM-dd-yyyy"];
}



-(void)viewWillAppear:(BOOL)animated{
    self.navigationItem.hidesBackButton = YES;
    if (!self.isNewSite) {
        [self checkIfSiteIsOpen];
        [self configureTextFields];
    }
}

-(void)checkIfSiteIsOpen{
    if (self.site){
        if (self.site.isReportComplete) {
            self.site = [[Site alloc]init];
            self.isNewSite = YES;
        }
        else {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Ooops!" message:@"Must submit last site report first" delegate:self cancelButtonTitle:@"Go To Current Tree" otherButtonTitles:@"Submit Site Report", @"View Site List", nil];
            [alert show];
        }
    }
    else {
        RLMResults *results = [Site allObjects];
        Site *mostRecentSite = [results lastObject];
        if (mostRecentSite) {
            if (mostRecentSite.isReportComplete) {
                self.site = [[Site alloc]init];
                self.isNewSite = YES;
            }
            else {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Ooops!" message:@"Must submit last site report first" delegate:self cancelButtonTitle:@"Go To Current Tree" otherButtonTitles:@"Submit Site Report", @"View Site List", nil];
                [alert show];
            }
        }
    }
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        [self.tabBarController setSelectedIndex:2];
    }
    if (buttonIndex == 1) {
        [self.tabBarController setSelectedIndex:3];
    }
    if (buttonIndex == 2) {
        [self.tabBarController setSelectedIndex:0];
    }
}




-(void)configureTextFields{
    self.locationField.delegate = self;
    self.buiField.delegate = self;
    self.activityField.delegate = self;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

#pragma TextField Delegate

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


- (IBAction)lodActionSheet:(id)sender {
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                             delegate:self
                                                    cancelButtonTitle:@"Select Level Of Disturbance"
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:kLODType1, kLODType23, kLODType4, nil];
    
    [actionSheet showInView:self.view];
}

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

-(void)selectFuelType:(Fuel *)fuel{
    self.fuelField.text = [NSString stringWithFormat:@"%@ - %@", fuel.abbreviation, fuel.name];
}

- (IBAction)addNewTree:(id)sender {
    UINavigationController *vc = (UINavigationController*)[[self.tabBarController viewControllers] objectAtIndex:2];
    self.site = [self createSite];
    TreeInfoViewController *destination = vc.viewControllers.firstObject;
    [destination setSite:self.site];
    [self.tabBarController setSelectedIndex:2];
    
    UINavigationController *navController = (UINavigationController *)[self.tabBarController.viewControllers objectAtIndex:3];
    SiteReviewViewController *siteReview = (SiteReviewViewController *)[navController.viewControllers firstObject];
    [siteReview setSite:self.site];
    
}

-(void)makeDtaID{
    NSString *firstString = [[self.dtaNameField.text substringWithRange:NSMakeRange(0, 3)]stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *secondString = [[self.dtaNameField.text substringFromIndex: [self.dtaNameField.text length]- 3]stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    self.dtaID = [[NSString stringWithFormat:@"%@%@", firstString, secondString ] uppercaseString];
}

-(NSString*)setSiteID{
    
    NSString *dateString = [self.dateFormat stringFromDate:[NSDate date]];

    [self makeDtaID];
    
    NSString *newSiteID = [NSString stringWithFormat:@"%@%@01", dateString, self.dtaID];
    
    NSString *currentDateAndDtaID = [NSString stringWithFormat:@"%@%@",dateString, self.dtaID];
    
    RLMResults *results = [Site allObjects];
    
    if (results.count > 0) {
        Site *site = [results lastObject];
        NSString *lastSiteID = [NSString stringWithFormat:@"%@",site.siteID];
        NSString *lastDateAndDtaID = [lastSiteID substringWithRange:NSMakeRange(0, 12)];
        
        // Check date and DTA to begin new day and count or continue count if same day
        if ([lastDateAndDtaID isEqualToString:currentDateAndDtaID]) {
            NSString *lastIDNum = [lastSiteID substringFromIndex:[lastSiteID length] - 2];
            int newID = [lastIDNum intValue] + 1;
            if (newID < 10) {
                newSiteID = [NSString stringWithFormat:@"%@%@%02d", dateString, self.dtaID, newID];
            }
            else {
                newSiteID = [NSString stringWithFormat:@"%@%@%d", dateString, self.dtaID, newID];
            }
        }
        else { // If a different date or DTA find last report by DTA
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
    self.site.siteID = [self setSiteID];
    self.site.formattedDtaID = self.dtaID;
    self.site.reportDate = [self.reportDateFormat stringFromDate:[NSDate date]];
    
    RLMRealm *realm = [RLMRealm defaultRealm];
    
    [realm beginWriteTransaction];
    [realm addObject:self.site];
    [realm commitWriteTransaction];
    
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
