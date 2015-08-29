//
//  BookCell.m
// 
//
//  Created by Kalvar Lin on 2015/8/29.
//  Copyright (c) 2015年 Kuo-Ming Lin. All rights reserved.
//

#import "BookCell.h"

@implementation BookCell

-(instancetype)init
{
    NSArray *_loadedNibs = [[NSBundle mainBundle] loadNibNamed:[BookCell className] owner:self options:nil];
    if( !_loadedNibs || _loadedNibs.count < 1 )
    {
        return nil;
    }
    self = [_loadedNibs objectAtIndex:0];
    if( self )
    {
        [_bookCover initilize];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [self init];
    if (self)
    {
        [self setFrame:frame];
    }
    return self;
}

-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [self init];
    if( self )
    {
        self.reuseIdentifier = reuseIdentifier;
    }
    return self;
}

#pragma --mark Public Methods
-(void)setBookColor:(UIColor *)_color
{
    _bookCover.backgroundColor = _color;
}

#pragma --mark Setters
-(void)setBookName:(NSString *)_name
{
    _bookName           = _name;
    _bookNameLabel.text = _bookName;
}

-(void)setBookCategory:(NSString *)_category
{
    _bookCategory           = _category;
    _bookCategoryLabel.text = [@"Category : " stringByAppendingString:_bookCategory];
    
    // Setup the background color depend on category
    _bookCover.category     = _bookCategory;
}

-(void)setBookPrice:(NSString *)_price
{
    _bookPrice           = _price;
    _bookPriceLabel.text = [@"Price : " stringByAppendingString:_bookPrice];
}

-(void)setSellRate:(float)_rate
{
    _sellRate       = _rate;
    dispatch_async(dispatch_get_main_queue(), ^{
        _rateLabel.text = [NSString stringWithFormat:@"Sell Rate : %.2f%%", _sellRate];
    });
}

-(void)setBuyRate:(float)_rate
{
    _buyRate        = _rate;
    dispatch_async(dispatch_get_main_queue(), ^{
        _rateLabel.text = [NSString stringWithFormat:@"Buy Rate : %.2f%%", _buyRate];
    });
}


@end