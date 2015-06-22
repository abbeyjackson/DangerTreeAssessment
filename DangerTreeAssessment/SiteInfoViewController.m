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

@interface SiteInfoViewController ()

@property (weak, nonatomic) IBOutlet UITextField *fireNumberField;
@property (weak, nonatomic) IBOutlet UITextField *dtaNameField;
@property (weak, nonatomic) IBOutlet UITextField *dtaUnitField;
@property (weak, nonatomic) IBOutlet UITextField *fuelField;
@property (weak, nonatomic) IBOutlet UITextField *locationField;
@property (weak, nonatomic) IBOutlet UITextField *buiField;
@property (weak, nonatomic) IBOutlet UITextField *lodField;
@property (weak, nonatomic) IBOutlet UITextField *activityField;

@property (strong, nonatomic) NSDateFormatter *dateFormat;
@property (strong, nonatomic) NSString *dtaID;

@end

@implementation SiteInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureTextFields];
    self.dateFormat = [[NSDateFormatter alloc] init];
    [self.dateFormat setDateFormat:@"yyMMdd"];
}

-(void)viewDidAppear:(BOOL)animated{
    self.navigationController.navigationItem.hidesBackButton = YES;
}

-(void)viewWillAppear:(BOOL)animated{
    self.navigationItem.hidesBackButton = YES;
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
    UIStoryboard *assessment = [UIStoryboard storyboardWithName:@"Assessment" bundle:nil];
    TreeInfoViewController *destination = [assessment instantiateViewControllerWithIdentifier:@"TreeInformation"];
    Site *site = [self createSite];
    [destination setSite:site];
    [self showViewController:destination sender:self];
}

-(NSString*)setSiteID{
    
    NSString *dateString = [self.dateFormat stringFromDate:[NSDate date]];
    self.dtaID = [[NSString stringWithFormat:@"%@%@", [self.dtaNameField.text substringWithRange:NSMakeRange(0, 3)] , [self.dtaNameField.text substringFromIndex: [self.dtaNameField.text length]- 3]] uppercaseString];
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
    Site *site = [[Site alloc] init];
    site.fireNumber = self.fireNumberField.text;
    site.dtaName = self.dtaNameField.text;
    site.dtaUnit = self.dtaUnitField.text;
    site.fuel = [self.fuelField.text substringToIndex:3];
    site.location = self.locationField.text;
    site.bui = self.buiField.text;
    site.lod = self.lodField.text;
    site.activity = self.activityField.text;
    site.siteID = [self setSiteID];
    site.formattedDtaID = self.dtaID;
    
    RLMRealm *realm = [RLMRealm defaultRealm];
    
    [realm beginWriteTransaction];
    [realm addObject:site];
    [realm commitWriteTransaction];
    
    return site;
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
