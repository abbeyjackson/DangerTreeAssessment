//
//  DataListCell.h
//  DangerTreeAssessment
//
//  Created by Abegael Jackson on 2015-06-16.
//  Copyright (c) 2015 Abbey Jackson & Alain Kahwaji. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Site;


@interface DataListCell : UITableViewCell


@property (nonatomic, strong) Site *object;

@property (weak, nonatomic) IBOutlet UILabel *reportNotCompleteStar;


@end
