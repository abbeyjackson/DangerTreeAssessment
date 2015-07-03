//
//  ReportLabel.m
//  DangerTreeAssessment
//
//  Created by Alain  on 2015-06-30.
//  Copyright (c) 2015 Abbey Jackson & Alain Kahwaji. All rights reserved.
//

#import "ReportLabel.h"


@implementation ReportLabel


#pragma mark - Lifecycle

-(instancetype)initWithLabel:(NSString*)label andDetail:(NSString*)detail{
    self = [super init];
    if (self) {
        _detail = detail;
        _label = label;
    }
    return self;
}


@end
