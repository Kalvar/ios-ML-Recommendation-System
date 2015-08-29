//
//  BookCell.h
// 
//
//  Created by Kalvar Lin on 2015/8/29.
//  Copyright (c) 2015年 Kuo-Ming Lin. All rights reserved.
//

@interface BookCell : UITableViewCell

@property (nonatomic, strong) NSString *bookId;
@property (nonatomic, strong) NSString *bookName;
@property (nonatomic, strong) NSString *bookCategory;
@property (nonatomic, strong) NSString *bookPrice;
@property (nonatomic, assign) float sellRate;
@property (nonatomic, assign) float buyRate;

@property (nonatomic, readwrite, copy) NSString *reuseIdentifier;

@property (nonatomic, weak) IBOutlet BookCover *bookCover;
@property (nonatomic, weak) IBOutlet UILabel *bookNameLabel;
@property (nonatomic, weak) IBOutlet UILabel *bookCategoryLabel;
@property (nonatomic, weak) IBOutlet UILabel *bookPriceLabel;
@property (nonatomic, weak) IBOutlet UILabel *rateLabel;

-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier;
-(void)setBookColor:(UIColor *)_color;

@end

