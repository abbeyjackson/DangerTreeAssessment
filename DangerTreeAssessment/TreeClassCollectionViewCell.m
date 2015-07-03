//
//  TreeClassCollectionViewCell.m
//  DangerTreeAssessment
//
//  Created by Abegael Jackson on 2015-06-17.
//  Copyright (c) 2015 Abbey Jackson & Alain Kahwaji. All rights reserved.
//

#import "TreeClassCollectionViewCell.h"

#import "TreeClass.h"

#import <UIKit/UIKit.h>


@interface TreeClassCollectionViewCell()


@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *numAndInfoLabel;


@end


@implementation TreeClassCollectionViewCell


#pragma mark - Custom Accessors

- (void)setObject:(TreeClass*)object {
    _object = object;
    [self configureCells];
}


#pragma mark - Setup

-(void)configureCells{
    self.numAndInfoLabel.text = self.object.numAndInfo;
    self.imageView.image = self.object.image;
}


@end
