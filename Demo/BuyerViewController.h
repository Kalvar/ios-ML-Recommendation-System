//
//  SellerViewController.h
// 
//
//  Created by Kalvar Lin on 2015/8/28.
//  Copyright (c) 2015年 Kuo-Ming Lin. All rights reserved.
//

@interface BuyerViewController : UIViewController

@property (nonatomic, weak) IBOutlet UILabel *nameLabel;
@property (nonatomic, weak) IBOutlet UILabel *categoryLabel;
@property (nonatomic, weak) IBOutlet UILabel *priceLabel;
@property (nonatomic, weak) IBOutlet UILabel *rateLabel;
@property (nonatomic, weak) IBOutlet UILabel *likeLabel;

@property (nonatomic, strong) NSString *bookId;
@property (nonatomic, strong) NSString *bookName;
@property (nonatomic, strong) NSString *bookCategory;
@property (nonatomic, strong) NSString *bookPrice;

@property (nonatomic, strong) NSDictionary *bookInfo;

-(void)setBookId:(NSString *)_id name:(NSString *)_name category:(NSString *)_category price:(NSString *)_price;

-(IBAction)buy:(id)sender;
-(IBAction)close:(id)sender;

@end
