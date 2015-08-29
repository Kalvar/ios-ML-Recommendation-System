//
//  AppDelegate.m
//  Recommendation System Demo V1.0
//
//  Created by Kalvar on 13/6/28.
//  Copyright (c) 2013 - 2015年 Kuo-Ming Lin (Kalvar Lin). All rights reserved.
//

#import "AppDelegate.h"

@implementation NSObject (Extensions)

+(NSString *)className
{
    return NSStringFromClass([self class]);
}

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    _storyboard     = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
    _sellerNetwork  = [[KRBPN alloc] init];
    _buyerNetwork   = [[KRBPN alloc] init];
    //_talkingNetwork = [[KRBPN alloc] init];
    
    [NSUserDefaults saveDefaultValue:[NSMutableDictionary new] forKey:kBooks];
    [NSUserDefaults saveDefaultValue:[NSMutableDictionary new] forKey:kBookSoldTimes];
    [NSUserDefaults saveDefaultValue:[NSMutableDictionary new] forKey:kBookBoughtTimes];
    [NSUserDefaults saveDefaultValue:[NSMutableDictionary new] forKey:kBookReviewedTimes];
    
    return YES;
}

#pragma --mark Public Methods
+(AppDelegate *)getAppDelegate
{
    return (AppDelegate *)[[UIApplication sharedApplication] delegate];
}

-(instancetype)getViewController:(NSString *)_className
{
    return [_storyboard instantiateViewControllerWithIdentifier:_className];
}

-(BOOL)canDoSellRate
{
    return _isSellerTrained;
}

-(BOOL)canDoBuyRate
{
    return _isBuyerTrained;
}

@end
