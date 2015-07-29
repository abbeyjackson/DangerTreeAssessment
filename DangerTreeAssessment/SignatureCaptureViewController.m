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

@end

@implementation SignatureCaptureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    self.title = @"Signature View";
    
    [self.signatureView setLineWidth:2.0];
    self.signatureView.foregroundLineColor = [UIColor colorWithRed:0.204 green:0.596 blue:0.859 alpha:1.000];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
