//
//  ViewController.m
//  Recommendation System Demo V1.0
//
//  Created by Kalvar on 13/6/28.
//  Copyright (c) 2013 - 2015年 Kuo-Ming Lin (Kalvar Lin). All rights reserved.
//

#import "ViewController.h"
#import "BooksViewController.h"

@implementation ViewController (fixSwitchs)

-(void)_showUserSexy
{
    self.sexyLabel.text  = ([[BooksDatabase sharedDatabase] getUserSexy] == 1) ? @"Male" : @"Female";
}

-(void)_showTrainingMode
{
    self.modeLabel.text  = ([[BooksDatabase sharedDatabase] getTrainingMode] == 1) ? @"Online" : @"Offline";
}

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self _showUserSexy];
    [self _showTrainingMode];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma --mark Methods
-(void)pushToBooksPage
{
    BooksViewController *_viewController = (BooksViewController *)[[AppDelegate getAppDelegate] getViewController:[BooksViewController className]];
    [self.navigationController pushViewController:_viewController animated:YES];
}

#pragma --mark IBActions
-(IBAction)switchSexy:(id)sender
{
    [[BooksDatabase sharedDatabase] switchUserSexy];
    [self _showUserSexy];
}

-(IBAction)trainingMode:(id)sender
{
    [[BooksDatabase sharedDatabase] switchTrainingMode];
    [self _showTrainingMode];
}

-(IBAction)toSellerPage:(id)sender
{
    [NSUserDefaults saveBoolValue:NO forKey:kIsBuyer];
    [self pushToBooksPage];
}

-(IBAction)toBuyerPage:(id)sender
{
    [NSUserDefaults saveBoolValue:YES forKey:kIsBuyer];
    [self pushToBooksPage];
}

-(IBAction)trainingSeller:(id)sender
{
    [self trainingSeller];
}

-(IBAction)trainingBuyer:(id)sender
{
    [self trainingBuyer];
}

-(void)trainingSeller
{
    NSMutableArray *_books = [[BooksDatabase sharedDatabase] getBooks];
    if( [_books count] < 1 )
    {
        return;
    }
    
    KRBPN *_nn = [AppDelegate getAppDelegate].sellerNetwork;
    _nn.learningRate     = 0.8f;
    _nn.convergenceError = 0.001f;
    _nn.limitIteration   = 1000;
    _nn.activeFunction   = KRBPNActivationBySigmoid;
    _nn.learningMode     = KRBPNLearningModeByQuickPropSmartHybrid;
    
    //Inputs : (category / 5), price, (reviwed times / 100), sexy, output is (bought times / 10) the expect value
    BooksDatabase *_bookDatbase = [BooksDatabase sharedDatabase];
    for( NSDictionary *_bookInfo in _books )
    {
        float _category           = [[_bookInfo objectForKey:kBookCategory] floatValue] / 5;
        float _price              = [[_bookInfo objectForKey:kBookPrice] floatValue] / 1000;
        NSInteger _reviewedTimes  = [_bookDatbase getReviwedTimesByBookId:[_bookInfo objectForKey:kBookId]];
        NSInteger _sexy           = [_bookDatbase getUserSexy];
        NSInteger _soldNumber     = [_bookDatbase getBuyTimesByBookId:[_bookInfo objectForKey:kBookId]];
        float _expectOutput       = _soldNumber / (float)kPerBookStored; // Sells Rate 的期望值可從這裡更改計算公式
        
        NSMutableArray *_patterns = [NSMutableArray new];
        [_patterns addObject:[NSNumber numberWithFloat:_category]];
        [_patterns addObject:[NSNumber numberWithFloat:_price]];
        [_patterns addObject:[NSNumber numberWithInteger:_reviewedTimes]];
        [_patterns addObject:[NSNumber numberWithInteger:_sexy]];
        
        [_nn addPatterns:_patterns
             outputGoals:@[[NSNumber numberWithInteger:_expectOutput]]];
    }
    
    [_nn setEachIteration:^(NSInteger times, NSDictionary *trainedInfo){
        //NSLog(@"Iterations : %li", times);
    }];
    
    [_nn setTrainingCompletion:^(BOOL success, NSDictionary *trainedInfo, NSInteger totalTimes){
        if( success )
        {
            [AppDelegate getAppDelegate].isSellerTrained = YES;
            //NSLog(@"Training done with total times : %li", totalTimes);
            //NSLog(@"TrainedInfo (Seller): %@", trainedInfo);
            //[_weakNN recoverNetwork];
        }
    }];
    
    [_nn trainingByRandomSettings];
    
}

-(void)trainingBuyer
{
    NSMutableArray *_books = [[BooksDatabase sharedDatabase] getBooks];
    if( [_books count] < 1 )
    {
        return;
    }
    
    KRBPN *_nn = [AppDelegate getAppDelegate].buyerNetwork;
    _nn.learningRate     = 0.6f;
    _nn.convergenceError = 0.001f;
    _nn.limitIteration   = 1000;
    _nn.activeFunction   = KRBPNActivationBySigmoid;
    _nn.learningMode     = KRBPNLearningModeByQuickPropSmartHybrid;
    
    //Inputs : (category / 5), price, (reviwed times / 100), sexy, output is (bought times / 10) the expect value
    BooksDatabase *_bookDatbase = [BooksDatabase sharedDatabase];
    for( NSDictionary *_bookInfo in _books )
    {
        float _category           = [[_bookInfo objectForKey:kBookCategory] floatValue] / 5;
        float _price              = [[_bookInfo objectForKey:kBookPrice] floatValue] / 1000;
        NSInteger _reviewedTimes  = [_bookDatbase getReviwedTimesByBookId:[_bookInfo objectForKey:kBookId]];
        NSInteger _soldNumber     = [_bookDatbase getBuyTimesByBookId:[_bookInfo objectForKey:kBookId]];
        float _expectOutput       = (_soldNumber > 0) ? 1.0f : 0.0f;
        
        NSMutableArray *_patterns = [NSMutableArray new];
        [_patterns addObject:[NSNumber numberWithFloat:_category]];
        [_patterns addObject:[NSNumber numberWithFloat:_price]];
        [_patterns addObject:[NSNumber numberWithInteger:_reviewedTimes]];
        
        [_nn addPatterns:_patterns
             outputGoals:@[[NSNumber numberWithInteger:_expectOutput]]];
    }
    
    [_nn setEachIteration:^(NSInteger times, NSDictionary *trainedInfo){
        //NSLog(@"Iterations : %li", times);
    }];
    
    [_nn setTrainingCompletion:^(BOOL success, NSDictionary *trainedInfo, NSInteger totalTimes){
        if( success )
        {
            [AppDelegate getAppDelegate].isBuyerTrained = YES;
            //NSLog(@"Training done with total times : %li", totalTimes);
            //NSLog(@"TrainedInfo (Seller): %@", trainedInfo);
            //[_weakNN recoverNetwork];
        }
    }];
    
    [_nn trainingByRandomSettings];
    
}

@end

