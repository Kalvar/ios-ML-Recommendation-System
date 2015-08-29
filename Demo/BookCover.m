//
//  BookCover.m
// 
//
//  Created by Kalvar Lin on 2015/8/28.
//  Copyright (c) 2015年 Kuo-Ming Lin. All rights reserved.
//

#import "BookCover.h"

@interface BookCover ()

@property (nonatomic, strong) NSDictionary *categories;

@end

@implementation BookCover

-(void)initilize
{
    _categories = @{@"games" : @1,
                    @"trips" : @2,
                    @"sales" : @3,
                    @"3c"    : @4};
}

#pragma --mark Setters
-(void)setCategory:(NSString *)_aCategory
{
    _category       = _aCategory;
    UIColor *_color = [UIColor brownColor];
    switch ([[_categories objectForKey:_category] integerValue])
    {
        case BookCategoryOnGame:
            _color = [UIColor purpleColor];
            break;
        case BookCategoryOnTrips:
            _color = [UIColor yellowColor];
            break;
        case BookCategoryOnSales:
            _color = [UIColor orangeColor];
            break;
        case BookCategoryOn3C:
            _color = [UIColor cyanColor];
            break;
        default:
            break;
    }
    
    [self setBackgroundColor:_color];
}

@end
