//
//  TreeInfoViewController.m
//  DangerTreeAssessment
//
//  Created by Abegael Jackson on 2015-06-16.
//  Copyright (c) 2015 Abbey Jackson & Alain Kahwaji. All rights reserved.
//

#import "TreeInfoViewController.h"
#import "Tree.h"

@interface TreeInfoViewController ()<UIActionSheetDelegate>

@property (weak, nonatomic) IBOutlet UITextField *latitudeField;
@property (weak, nonatomic) IBOutlet UITextField *longitudeField;
@property (weak, nonatomic) IBOutlet UITextField *speciesField;
@property (weak, nonatomic) IBOutlet UITextField *classField;
@property (weak, nonatomic) IBOutlet UITextField *wildlifeValueField;

@end

@implementation TreeInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureTextFields];
    
    
}

-(Tree*)createTree{
    
    Tree *tree = [[Tree alloc]init];
    tree.site = self.site;
    tree.lat = [self.latitudeField.text doubleValue];
    tree.lon = [self.longitudeField.text doubleValue];
//    tree.species = self.speciesField.text; ENUM
//    tree.class = self.classField.text; ENUM
//    tree.wildLifeValue = self.wildlifeValueField.text; ENUM
    
    RLMRealm *realm = [RLMRealm defaultRealm];
    
    [realm beginWriteTransaction];
    [realm addObject:tree];
    [realm commitWriteTransaction];
    
    return tree;
}

-(void)configureTextFields{
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
                                                    otherButtonTitles:@"HIGH", @"MEDIUM", @"LOW", nil];
    
    [actionSheet showInView:self.view];
}

- (IBAction)saveNewTreeButton:(id)sender {
    
    if (self.site.lod == LOD1) {
        [self performSegueWithIdentifier:@"showTreeLOD1" sender: self];
    }
    if (self.site.lod == LOD23) {
        [self performSegueWithIdentifier:@"showTreeLOD23" sender: self];
    }
    if (self.site.lod == LOD4) {
        [self performSegueWithIdentifier:@"showTreeLOD4" sender: self];
    }
    
}



#pragma mark - Navigation


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showTreeLOD1"]) {
        Tree *tree = [self createTree];
        [[segue destinationViewController] setDetailItem:tree];
    }
    if ([[segue identifier] isEqualToString:@"showTreeLOD23"]) {
        Tree *tree = [self createTree];
        [[segue destinationViewController] setDetailItem:tree];
    }
    if ([[segue identifier] isEqualToString:@"showTreeLOD4"]) {
        Tree *tree = [self createTree];
        [[segue destinationViewController] setDetailItem:tree];
    }
}


- (IBAction)unwindToTreeInfo:(UIStoryboardSegue*)sender{
}

@end
