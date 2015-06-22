//
//  DataListCell.m
//  DangerTreeAssessment
//
//  Created by Abegael Jackson on 2015-06-16.
//  Copyright (c) 2015 Abbey Jackson & Alain Kahwaji. All rights reserved.
//

#import "DataListCell.h"
#import "Site.h"

@interface DataListCell()

@property (weak, nonatomic) IBOutlet UILabel *reportDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *fireNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *siteLocationLabel;
@property (weak, nonatomic) IBOutlet UILabel *dtaNameLabel;

@end

@implementation DataListCell


- (void)setObject:(Site*)object {
    _object = object;
    
    [self configure];
}

#pragma mark - General methods -

- (void)configure {
    self.reportDateLabel.text = self.object.reportDate;
    self.fireNumberLabel.text = self.object.fireNumber;
    self.siteLocationLabel.text = self.object.location;
    self.dtaNameLabel.text = self.object.dtaName;
}

@end
