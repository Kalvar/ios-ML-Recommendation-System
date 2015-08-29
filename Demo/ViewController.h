//
//  ViewController.h
//  Recommendation System Demo V1.0
//
//  Created by Kalvar on 13/6/28.
//  Copyright (c) 2013 - 2015年 Kuo-Ming Lin (Kalvar Lin). All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (nonatomic, weak) IBOutlet UILabel *sexyLabel;
@property (nonatomic, weak) IBOutlet UILabel *modeLabel;

-(IBAction)switchSexy:(id)sender;
-(IBAction)trainingMode:(id)sender;

-(IBAction)toSellerPage:(id)sender;
-(IBAction)toBuyerPage:(id)sender;
-(IBAction)trainingSeller:(id)sender;
-(IBAction)trainingBuyer:(id)sender;

@end
