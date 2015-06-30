//
//  ReportLabel.m
//  DangerTreeAssessment
//
//  Created by Alain  on 2015-06-30.
//  Copyright (c) 2015 Abbey Jackson & Alain Kahwaji. All rights reserved.
//

#import "ReportLabel.h"

@implementation ReportLabel

-(instancetype)initWithLabel:(NSString*)label andDetail:(NSString*)detail{
    self = [super init];
    if (self) {
        _label = label;
        _detail = detail;
    }
    return self;
}

@end
