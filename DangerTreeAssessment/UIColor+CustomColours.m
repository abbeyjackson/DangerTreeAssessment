//
//  UIColor+CustomColours.m
//  DangerTreeAssessment
//
//  Created by Abegael Jackson on 2015-06-23.
//  Copyright (c) 2015 Abbey Jackson & Alain Kahwaji. All rights reserved.
//

#import "UIColor+CustomColours.h"

@implementation UIColor (CustomColours)




//+(UIColor*)flatWhiteColor{
//    return [UIColor colorWithRed:0.9274 green:0.9436 blue:0.95 alpha:1.0];
//}

//+(UIColor*)blackColor{
//    return [UIColor colorWithRed:0.1674 green:0.1674 blue:0.1674 alpha:1.0];
//    return [UIColor blackColor];
//}

//+(UIColor*)flatBlueColor{
//    return [UIColor colorWithRed:0.3132 green:0.3974 blue:0.6365 alpha:1.0];
//}

+(UIColor*)redColor{
    return [UIColor colorWithRed:0.9115 green:0.2994 blue:0.2335 alpha:1.0];
}

+(UIColor*)lightGrayColor{
    return [UIColor colorWithWhite:0.667 alpha:0.65];
}

//-(UIImage*)pixelImage{
//    {
//        CGRect rect = CGRectMake(0, 0, 1, 1);
//        UIGraphicsBeginImageContext(rect.size);
//        CGContextRef context = UIGraphicsGetCurrentContext();
//
//        CGContextSetFillColorWithColor(context, [self CGColor]);
//        CGContextFillRect(context, rect);
//
//        UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
//        UIGraphicsEndImageContext();
//
//        return image;
//    }
//}


@end
