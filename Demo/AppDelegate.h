//
//  AppDelegate.h
//  Recommendation System Demo V1.0
//
//  Created by Kalvar on 13/6/28.
//  Copyright (c) 2013 - 2015年 Kuo-Ming Lin (Kalvar Lin). All rights reserved.
//

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, strong) UIStoryboard *storyboard;
@property (nonatomic, strong) KRBPN *sellerNetwork;         // 賣家看到商品賣出去的機率
@property (nonatomic, strong) KRBPN *buyerNetwork;          // 買家能看到自己喜歡的商品 (買的機率)
@property (nonatomic, strong) KRBPN *talkingNetwork;        // 2 個 NN 互相溝通、訓練、交換資訊 (Optional)

@property (nonatomic, assign) BOOL isSellerTrained;
@property (nonatomic, assign) BOOL isBuyerTrained;

+(AppDelegate *)getAppDelegate;
-(instancetype)getViewController:(NSString *)_className;
-(BOOL)canDoSellRate;
-(BOOL)canDoBuyRate;

@end

@interface NSObject (Extensions)

+(NSString *)className;

@end
