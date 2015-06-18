//
//  TreeClassTableViewCell.m
//  DangerTreeAssessment
//
//  Created by Abegael Jackson on 2015-06-17.
//  Copyright (c) 2015 Abbey Jackson & Alain Kahwaji. All rights reserved.
//

#import "TreeClassTableViewCell.h"
#import "TreeClass.h"
#import <UIKit/UIKit.h>

@interface TreeClassTableViewCell()
@property (weak, nonatomic) IBOutlet UILabel *numAndInfoLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;


@end

@implementation TreeClassTableViewCell

- (void)setObject:(TreeClass*)object {
    _object = object;
    
    [self configureCells];
}

-(void)configureCells{
    self.numAndInfoLabel.text = self.object.numAndInfo;
    self.descriptionLabel.text = self.object.details;
    self.imageView.image = self.object.image;
}

@end
                           
                           
                           
                           
                           
                           
                           
                           
                           
                           
