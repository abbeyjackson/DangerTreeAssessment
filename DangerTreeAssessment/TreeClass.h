//
//  TreeClass.h
//  DangerTreeAssessment
//
//  Created by Abegael Jackson on 2015-06-17.
//  Copyright (c) 2015 Abbey Jackson & Alain Kahwaji. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>


@interface TreeClass : NSObject


@property (nonatomic, strong) NSString *details;
@property (nonatomic, strong) NSString *numAndInfo;

@property (nonatomic, strong) UIImage *image;


-(instancetype)initWithImage:(UIImage *)image numAndInfo:(NSString*)numAndInfo;


@end
