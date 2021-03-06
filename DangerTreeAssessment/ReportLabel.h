//
//  ReportLabel.h
//  DangerTreeAssessment
//
//  Created by Alain  on 2015-06-30.
//  Copyright (c) 2015 Abbey Jackson & Alain Kahwaji. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ReportLabel : NSObject


@property (strong, nonatomic) NSString *detail;
@property (strong, nonatomic) NSString *label;


-(instancetype)initWithLabel:(NSString*)label andDetail:(NSString*)detail;


@end
