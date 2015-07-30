//
//  SignatureCaptureViewController.m
//  DangerTreeAssessment
//
//  Created by Abegael Jackson on 2015-07-29.
//  Copyright (c) 2015 Abbey Jackson & Alain Kahwaji. All rights reserved.
//

#import "SignatureCaptureViewController.h"

#import <SignatureView/SignatureView.h>

@interface SignatureCaptureViewController ()

@property (weak, nonatomic) IBOutlet UIButton *doneButton;
@property (weak, nonatomic) IBOutlet UILabel *pleaseSignLabel;

@end

@implementation SignatureCaptureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.doneButton.transform = CGAffineTransformMakeRotation( ( 270 * M_PI ) / 180 );
    self.pleaseSignLabel.transform = CGAffineTransformMakeRotation( ( 270 * M_PI ) / 180 );
    self.signatureView.layer.borderWidth = 2.0;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
