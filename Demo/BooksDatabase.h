//
//  BookCover.h
// 
//
//  Created by Kalvar Lin on 2015/8/28.
//  Copyright (c) 2015年 Kuo-Ming Lin. All rights reserved.
//

@interface BooksDatabase : NSObject

+(instancetype)sharedDatabase;
-(void)addBookWithName:(NSString *)_name category:(NSString *)_category price:(NSString *)_price;
-(void)modifyBookWithId:(NSString *)_bookId name:(NSString *)_name category:(NSString *)_category price:(NSString *)_price;
-(void)buyBookById:(NSString *)_bookId;                                     // 記錄該商品被購買次數
-(void)recordReviewedTimesWithBookId:(NSString *)_bookId;                   // 記錄該商品被瀏覽次數
-(void)recordStayedSeconds:(NSInteger)_seconds bookId:(NSString *)_bookId;  // 記錄該商品總停留時間 (Optional)

-(NSMutableArray *)getBooks;
-(NSInteger)getBuyTimesByBookId:(NSString *)_bookId;
-(NSInteger)getReviwedTimesByBookId:(NSString *)_bookId;

-(NSInteger)getTrainingMode;
-(void)switchTrainingMode;

-(NSInteger)getUserSexy;
-(void)switchUserSexy;


@end
