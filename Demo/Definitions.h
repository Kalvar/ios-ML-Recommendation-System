//
//  Definitions.h
// 
//
//  Created by Kalvar Lin on 2015/8/29.
//  Copyright (c) 2015年 Kuo-Ming Lin. All rights reserved.
//

typedef enum BookCategories
{
    BookCategoryOnGame = 1,
    BookCategoryOnTrips,
    BookCategoryOnSales,
    BookCategoryOn3C
}BookCategories;

static NSString *kIsBuyer           = @"kIsBuyer";
static NSString *kBooks             = @"kBooks";
static NSString *kBookId            = @"id";
static NSString *kBookName          = @"name";
static NSString *kBookCategory      = @"category";
static NSString *kBookPrice         = @"price";
static NSString *kBookRate          = @"rate";
static NSString *kBookSoldTimes     = @"soldTimes";
static NSString *kBookBoughtTimes   = @"boughtTimes";
static NSString *kBookReviewedTimes = @"reviewedTimes";

static NSString *kUserSexy          = @"kUserSexy";  // 1 Male, 0 Female
static NSString *kTrainingMode      = @"kTrainingMode";  // 1 Online Training, 0 Offline Training (Batch)

static NSInteger kPerBookStored     = 10; // 每款書都是庫存 10 本

