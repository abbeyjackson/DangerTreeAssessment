//
//  TreeClass.m
//  DangerTreeAssessment
//
//  Created by Abegael Jackson on 2015-06-17.
//  Copyright (c) 2015 Abbey Jackson & Alain Kahwaji. All rights reserved.
//

#import "TreeClass.h"
#import <UIKit/UIKit.h>

@interface TreeClass()

@end

@implementation TreeClass

-(instancetype)initWithImage:(UIImage *)image numAndInfo:(NSString*)numAndInfo andDetails:(NSString*)details{
    self = [super init];
    if (self) {
        _image = image;
        _numAndInfo = numAndInfo;
        _details = details;
    }
    return self;
}

@end
