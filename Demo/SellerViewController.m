//
//  SellerViewController.m
// 
//
//  Created by Kalvar Lin on 2015/8/28.
//  Copyright (c) 2015年 Kuo-Ming Lin. All rights reserved.
//

#import "SellerViewController.h"

@implementation SellerViewController (fixSells)

-(BOOL)_isModify
{
    return (self.bookId != nil) && ([self.bookId length] > 0);
}

-(void)_predicate
{
    if( [[AppDelegate getAppDelegate] canDoSellRate] )
    {
        KRBPN *_nn                = [AppDelegate getAppDelegate].sellerNetwork;
        float _category           = [[self.bookInfo objectForKey:kBookCategory] floatValue] / 5;
        float _price              = [[self.bookInfo objectForKey:kBookPrice] floatValue] / 1000;
        NSInteger _reviewedTimes  = [[BooksDatabase sharedDatabase] getReviwedTimesByBookId:[self.bookInfo objectForKey:kBookId]];
        NSInteger _sexy           = [[BooksDatabase sharedDatabase] getUserSexy];
        
        NSMutableArray *_patterns = [NSMutableArray new];
        [_patterns addObject:[NSNumber numberWithFloat:_category]];
        [_patterns addObject:[NSNumber numberWithFloat:_price]];
        [_patterns addObject:[NSNumber numberWithFloat:(_reviewedTimes / 100.0f)]];
        [_patterns addObject:[NSNumber numberWithInteger:_sexy]];
        
        [_nn setTrainingCompletion:^(BOOL success, NSDictionary *trainedInfo, NSInteger totalTimes){
            float _rate   = [[[trainedInfo objectForKey:KRBPNTrainedOutputResults] firstObject] floatValue] * 100;
            self.rateLabel.text = [NSString stringWithFormat:@"%.2f%%", _rate];
            NSLog(@"sell rate : %f", _rate);
        }];
        
        NSLog(@"kTrainingMode x : %li", [[BooksDatabase sharedDatabase] getTrainingMode]);
        
        if( [[BooksDatabase sharedDatabase] getTrainingMode] == 1 )
        {
            //NSLog(@"online training : %@", _patterns);
            // 賣越多，對剩下的商品期望就越高
            NSInteger _soldNumber = [[BooksDatabase sharedDatabase] getBuyTimesByBookId:[self.bookInfo objectForKey:kBookId]];
            float _expectOutput   = _soldNumber / (float)kPerBookStored;
            [_nn trainingWithAddPatterns:_patterns outputGoals:@[[NSNumber numberWithFloat:_expectOutput]]];
        }
        else
        {
            [_nn directOutputAtInputs:_patterns];
        }
    }
}

@end

@implementation SellerViewController

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
    [_bookCover initilize];
    if( [self _isModify] )
    {
        [_addButton setHidden:YES];
        _nameField.text     = _bookName;
        _categoryField.text = _bookCategory;
        _priceField.text    = _bookPrice;
        _boughtLabel.text   = [NSString stringWithFormat:@"%li / %li",
                               [[BooksDatabase sharedDatabase] getBuyTimesByBookId:_bookId],
                               kPerBookStored];
        _reviewedLabel.text = [NSString stringWithFormat:@"%li", [[BooksDatabase sharedDatabase] getReviwedTimesByBookId:_bookId]];
        [self _predicate];
    }
    else
    {
        [_modifyButton setHidden:YES];
    }
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
}

#pragma --mark IBActions
-(IBAction)modifyBook:(id)sender
{
    [[BooksDatabase sharedDatabase] modifyBookWithId:_bookId
                                                name:_nameField.text
                                            category:_categoryField.text
                                               price:_priceField.text];
    [self.navigationController popViewControllerAnimated:YES];
}

-(IBAction)addBook:(id)sender
{
    [[BooksDatabase sharedDatabase] addBookWithName:_nameField.text
                                           category:_categoryField.text
                                              price:_priceField.text];
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma --mark UITextFieldDelegate
// Start in editing
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    textField.returnKeyType      = UIReturnKeyDone;
    textField.keyboardAppearance = UIKeyboardAppearanceAlert;
    return YES;
}

// Pressed done button
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

// Done the edition
-(BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    if( textField == _categoryField )
    {
        // Changes the BookCover color
        _bookCover.category = textField.text;
    }
    return YES;
}

#pragma --mark Public Methods
-(void)setBookId:(NSString *)_id name:(NSString *)_name category:(NSString *)_category price:(NSString *)_price
{
    _bookId       = _id;
    _bookName     = _name;
    _bookCategory = _category;
    _bookPrice    = _price;
}


@end