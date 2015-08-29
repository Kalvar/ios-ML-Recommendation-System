//
//  BookCover.m
// 
//
//  Created by Kalvar Lin on 2015/8/28.
//  Copyright (c) 2015年 Kuo-Ming Lin. All rights reserved.
//

#import "BooksDatabase.h"

@implementation BooksDatabase

+(instancetype)sharedDatabase
{
    static dispatch_once_t pred;
    static BooksDatabase *_object = nil;
    dispatch_once(&pred, ^{
        _object = [[BooksDatabase alloc] init];
    });
    return _object;
}

-(void)addBookWithName:(NSString *)_name category:(NSString *)_category price:(NSString *)_price
{
    NSMutableDictionary *_savedBooks = [NSMutableDictionary dictionaryWithDictionary:[NSUserDefaults defaultValueForKey:kBooks]];
    NSString *_bookId                = [NSString stringWithFormat:@"book%li", [_savedBooks count]];
    NSMutableDictionary *_books      = [[NSMutableDictionary alloc] initWithDictionary:@{kBookId       : _bookId,
                                                                                         kBookName     : _name,
                                                                                         kBookCategory : _category,
                                                                                         kBookPrice    : _price}];
    [_savedBooks setValue:_books forKey:_bookId];
    [NSUserDefaults saveDefaultValue:_savedBooks forKey:kBooks];
}

-(void)modifyBookWithId:(NSString *)_bookId name:(NSString *)_name category:(NSString *)_category price:(NSString *)_price
{
    NSMutableDictionary *_savedBooks = [NSMutableDictionary dictionaryWithDictionary:[NSUserDefaults defaultValueForKey:kBooks]];
    NSMutableDictionary *_books      = [NSMutableDictionary dictionaryWithDictionary:[_savedBooks objectForKey:_bookId]];
    if( nil != _books )
    {
        [_books setObject:_bookId forKey:kBookId];
        [_books setObject:_name forKey:kBookName];
        [_books setObject:_category forKey:kBookCategory];
        [_books setObject:_price forKey:kBookPrice];
    }
    [_savedBooks setValue:_books forKey:_bookId];
    [NSUserDefaults saveDefaultValue:_savedBooks forKey:kBooks];
}

-(void)buyBookById:(NSString *)_bookId
{
    NSMutableDictionary *_times = [NSMutableDictionary dictionaryWithDictionary:[NSUserDefaults defaultValueForKey:kBookBoughtTimes]];
    NSNumber *_boughtTimes      = [_times objectForKey:_bookId];
    int _recordTimes            = 0;
    if( nil != _boughtTimes )
    {
        _recordTimes = [_boughtTimes intValue];
    }
    [_times setObject:[NSNumber numberWithInteger:(_recordTimes + 1)] forKey:_bookId];
    [NSUserDefaults saveDefaultValue:_times forKey:kBookBoughtTimes];
}

-(void)recordReviewedTimesWithBookId:(NSString *)_bookId
{
    NSMutableDictionary *_times = [NSMutableDictionary dictionaryWithDictionary:[NSUserDefaults defaultValueForKey:kBookReviewedTimes]];
    NSNumber *_reviewedTimes    = [_times objectForKey:_bookId];
    int _recordTimes            = 0;
    if( nil != _reviewedTimes )
    {
        _recordTimes = [_reviewedTimes intValue];
    }
    [_times setObject:[NSNumber numberWithInteger:(_recordTimes + 1)] forKey:_bookId];
    [NSUserDefaults saveDefaultValue:_times forKey:kBookReviewedTimes];
}

-(NSMutableArray *)getBooks
{
    return [[NSMutableArray alloc] initWithArray:[[NSUserDefaults defaultValueForKey:kBooks] allValues]];
}

-(NSInteger)getBuyTimesByBookId:(NSString *)_bookId
{
    NSMutableDictionary *_times = [NSUserDefaults defaultValueForKey:kBookBoughtTimes];
    NSNumber *_boughtTimes      = [_times objectForKey:_bookId];
    int _recordTimes            = 0;
    if( nil != _boughtTimes )
    {
        _recordTimes = [_boughtTimes intValue];
    }
    return _recordTimes;
}

-(NSInteger)getReviwedTimesByBookId:(NSString *)_bookId
{
    NSMutableDictionary *_times = [NSUserDefaults defaultValueForKey:kBookReviewedTimes];
    NSNumber *_reviewedTimes    = [_times objectForKey:_bookId];
    int _recordTimes            = 0;
    if( nil != _reviewedTimes )
    {
        _recordTimes = [_reviewedTimes intValue];
    }
    return _recordTimes;
}

-(NSInteger)getTrainingMode
{
    NSNumber *_number = [NSUserDefaults defaultValueForKey:kTrainingMode];
    return ( nil != _number ) ? [_number integerValue] : 0;
}

-(void)switchTrainingMode
{
    NSNumber *_number  = [NSUserDefaults defaultValueForKey:kTrainingMode];
    NSInteger _mode    = [_number integerValue];
    _mode             += ( [_number integerValue] == 1 ) ? -1 : 1;
    [NSUserDefaults saveDefaultValue:[NSNumber numberWithInteger:_mode] forKey:kTrainingMode];
}

-(NSInteger)getUserSexy
{
    NSNumber *_number = [NSUserDefaults defaultValueForKey:kUserSexy];
    return ( nil != _number ) ? [_number integerValue] : 0;
}

-(void)switchUserSexy
{
    NSNumber *_number  = [NSUserDefaults defaultValueForKey:kUserSexy];
    NSInteger _sexy    = [_number integerValue];
    _sexy             += ( [_number integerValue] == 1 ) ? -1 : 1;
    [NSUserDefaults saveDefaultValue:[NSNumber numberWithInteger:_sexy] forKey:kUserSexy];
}

// Optional
-(void)recordStayedSeconds:(NSInteger)_seconds bookId:(NSString *)_bookId
{
    // ...
}

@end
