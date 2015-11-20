//
//  SellerViewController.m
// 
//
//  Created by Kalvar Lin on 2015/8/28.
//  Copyright (c) 2015年 Kuo-Ming Lin. All rights reserved.
//

#import "BuyerViewController.h"

@implementation BuyerViewController (fixBuys)

-(void)_predicate
{
    if( [[AppDelegate getAppDelegate] canDoBuyRate] )
    {
        // 手動量化最小 for Demo
        KRBPN *_nn                = [AppDelegate getAppDelegate].buyerNetwork;
        float _category           = [[self.bookInfo objectForKey:kBookCategory] floatValue] / 5;
        float _price              = [[self.bookInfo objectForKey:kBookPrice] floatValue] / 1000;
        NSInteger _reviewedTimes  = [[BooksDatabase sharedDatabase] getReviwedTimesByBookId:[self.bookInfo objectForKey:kBookId]];
        
        NSMutableArray *_patterns = [NSMutableArray new];
        [_patterns addObject:[NSNumber numberWithFloat:_category]];
        [_patterns addObject:[NSNumber numberWithFloat:_price]];
        [_patterns addObject:[NSNumber numberWithFloat:(_reviewedTimes / 100.0f)]];
        
        // 取得 NN Output 當前 Book 的購買率
        [_nn setTrainingCompletion:^(BOOL success, NSDictionary *trainedInfo, NSInteger totalTimes){
            float _rate         = [[[trainedInfo objectForKey:KRBPNTrainedOutputResults] firstObject] floatValue] * 100;
            self.rateLabel.text = [NSString stringWithFormat:@"%.2f%%", _rate];
            NSLog(@"buy rate : %f", _rate);
        }];
        
        // 性別是 Male 就訓練 NN 後再輸出
        if( [[BooksDatabase sharedDatabase] getUserSexy] == 1 )
        {
            // 只看不買，對剩下的商品就越沒興趣
            NSInteger _soldNumber = [[BooksDatabase sharedDatabase] getBuyTimesByBookId:[self.bookInfo objectForKey:kBookId]];
            // 有買過就有興趣
            float _expectOutput   = (_soldNumber > 0) ? 1.0f : 0.0f;
            [_nn trainingWithAddPatterns:_patterns outputGoals:@[[NSNumber numberWithFloat:_expectOutput]]];
        }
        else
        {
            // 性別是 Female 就直接輸出而不訓練 NN
            [_nn directOutputAtInputs:_patterns];
        }
        
        // 推薦商品
        // 先列舉所有商品來進行選擇
        NSMutableArray *_books      = [[BooksDatabase sharedDatabase] getBooks];
        NSMutableArray *_recommends = [NSMutableArray new];
        for( NSDictionary *_bookInfo in _books )
        {
            NSString *_bookId         = [_bookInfo objectForKey:kBookId];
            if( [_bookId isEqualToString:self.bookId] )
            {
                continue;
            }
            float _category           = [[_bookInfo objectForKey:kBookCategory] floatValue] / 5;
            float _price              = [[_bookInfo objectForKey:kBookPrice] floatValue] / 1000;
            NSInteger _reviewedTimes  = [[BooksDatabase sharedDatabase] getReviwedTimesByBookId:[_bookInfo objectForKey:kBookId]];
            
            NSMutableArray *_patterns = [NSMutableArray new];
            [_patterns addObject:[NSNumber numberWithFloat:_category]];
            [_patterns addObject:[NSNumber numberWithFloat:_price]];
            [_patterns addObject:[NSNumber numberWithInteger:_reviewedTimes]];
            
            // 丟到 NN 進行喜好程度的訓練
            [_nn setTrainingCompletion:^(BOOL success, NSDictionary *trainedInfo, NSInteger totalTimes) {
                [_recommends addObject:@{kBookId   : _bookId,
                                         kBookName : [_bookInfo objectForKey:kBookName],
                                         kBookRate : [[trainedInfo objectForKey:KRBPNTrainedOutputResults] firstObject]}];
                //NSLog(@"here : %@", [_bookInfo objectForKey:kBookName]);
            }];
            
            //NSLog(@"_patterns : %@", _patterns);
            [_nn directOutputAtInputsOnMainThread:_patterns];
        }
        
        if( [_recommends count] > 0 )
        {
            // 排序取出最大機率的商品
            float _maxValue         = -1.0f;
            NSString *_bestBookId   = @"";
            NSString *_bestBookName = @"";
            for ( NSDictionary *_results in _recommends )
            {
                // 取出 NN 推論出的感興趣程度( kBookRate )來判斷購買率
                NSNumber *_output = [_results objectForKey:kBookRate];
                if( [_output floatValue] > _maxValue )
                {
                    _maxValue     = [_output floatValue];
                    _bestBookId   = [_results objectForKey:kBookId];
                    _bestBookName = [_results objectForKey:kBookName];
                }
            }
            
            // 取得最佳推薦
            if( [_bestBookId length] > 0 )
            {
                //NSLog(@"_bestBookId : %@ / %@", _bestBookId, _bestBookName);
                self.likeLabel.text = _bestBookName;
            }
        }
        
    }
}

@end

@implementation BuyerViewController

-(instancetype)init
{
    self = [super init];
    if( self )
    {
        
    }
    return self;
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    [[BooksDatabase sharedDatabase] recordReviewedTimesWithBookId:_bookId];
    _nameLabel.text     = _bookName;
    _categoryLabel.text = _bookCategory;
    _priceLabel.text    = _bookPrice;
    [self _predicate];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
}

#pragma --mark Public Methods
-(void)setBookId:(NSString *)_id name:(NSString *)_name category:(NSString *)_category price:(NSString *)_price
{
    _bookId       = _id;
    _bookName     = _name;
    _bookCategory = _category;
    _bookPrice    = _price;
}

#pragma --mark IBActions
-(IBAction)buy:(id)sender
{
    [[BooksDatabase sharedDatabase] buyBookById:_bookId];
    [self.navigationController popViewControllerAnimated:YES];
}

-(IBAction)close:(id)sender
{
    // Optional
    //[[BooksDatabase sharedDatabase] recordStayedSeconds:10 bookId:_bookId];
    [self.navigationController popViewControllerAnimated:YES];
}

@end