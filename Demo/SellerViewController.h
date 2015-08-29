//
//  SellerViewController.h
// 
//
//  Created by Kalvar Lin on 2015/8/28.
//  Copyright (c) 2015年 Kuo-Ming Lin. All rights reserved.
//

@interface SellerViewController : UIViewController<UITextFieldDelegate>

@property (nonatomic, strong) NSString *bookId;

@property (nonatomic, weak) IBOutlet BookCover *bookCover;
@property (nonatomic, weak) IBOutlet UITextField *nameField;
@property (nonatomic, weak) IBOutlet UITextField *categoryField;
@property (nonatomic, weak) IBOutlet UITextField *priceField;
@property (nonatomic, weak) IBOutlet UILabel *boughtLabel;
@property (nonatomic, weak) IBOutlet UILabel *reviewedLabel;
@property (nonatomic, weak) IBOutlet UILabel *rateLabel;

@property (nonatomic, weak) IBOutlet UIButton *modifyButton;
@property (nonatomic, weak) IBOutlet UIButton *addButton;

@property (nonatomic, strong) NSString *bookName;
@property (nonatomic, strong) NSString *bookCategory;
@property (nonatomic, strong) NSString *bookPrice;

@property (nonatomic, strong) NSDictionary *bookInfo; // Demo Training Usage

-(IBAction)modifyBook:(id)sender;
-(IBAction)addBook:(id)sender;

-(void)setBookId:(NSString *)_id name:(NSString *)_name category:(NSString *)_category price:(NSString *)_price;

@end
