//
//  TreeLOD4ViewController.m
//  DangerTreeAssessment
//
//  Created by Abegael Jackson on 2015-06-16.
//  Copyright (c) 2015 Abbey Jackson & Alain Kahwaji. All rights reserved.
//

#import "TreeLOD4ViewController.h"

#import "Constants.h"
#import "UIColor+CustomColours.h"

#import "Site.h"
#import "Tree.h"


@interface TreeLOD4ViewController ()<UIActionSheetDelegate>

@property (weak, nonatomic) IBOutlet UITextField *ratingField;

@end


@implementation TreeLOD4ViewController


#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
}


#pragma mark - Analysis

-(void)checkIfNewTree{
    if (self.tree) {
        if (self.tree.isComplete) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"No Current Tree" message:@"What would you like to do next?" delegate:self cancelButtonTitle:@"View Site List" otherButtonTitles:@"New Tree", @"Submit Report", nil];
            [alert show];
        }
        else {
            // let user edit current tree
        }
    }
    else {
    }
}


#pragma mark - IBActions

- (IBAction)ratingActionSheet:(id)sender {
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                             delegate:self
                                                    cancelButtonTitle:@"Select Rating"
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles: kDangerous, kClass1, kClass2NoDefects, kClass2LowFailure, kClass3NoDefects, nil];
    [actionSheet showInView:self.view];
    
}

- (IBAction)saveTreeAssessmentButton:(id)sender {
    [self saveLOD4];
    [self performSegueWithIdentifier:@"showTreeMgt" sender: self];
}


#pragma mark - Action Sheet

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0) {
        self.ratingField.text = kDangerous;
    }
    if (buttonIndex == 1) {
        self.ratingField.text = kClass1;
    }
    if (buttonIndex == 2) {
        self.ratingField.text = kClass2NoDefects;
    }
    if (buttonIndex == 3) {
        self.ratingField.text = kClass2LowFailure;
    }
    if (buttonIndex == 4) {
        self.ratingField.text = kClass3NoDefects;
    }
}


#pragma mark - Save Data

-(void)saveLOD4{
    self.tree.rating = self.ratingField.text;
}


#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([[segue identifier] isEqualToString:@"showTreeMgt"]) {
        [[segue destinationViewController] setTree:self.tree];
        [[segue destinationViewController] setSite:self.site];
    }
}

@end
