//
//  SellerViewController.m
// 
//
//  Created by Kalvar Lin on 2015/8/28.
//  Copyright (c) 2015年 Kuo-Ming Lin. All rights reserved.
//

#import "BooksViewController.h"
#import "SellerViewController.h"
#import "BuyerViewController.h"

static NSString *cellIdentifier = @"bookCell";

@interface BooksViewController ()

@property (nonatomic, assign) BOOL isBuyer;

@end

@implementation BooksViewController (fixSells)


@end

@implementation BooksViewController

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
    _books   = [NSMutableArray new];
    _isBuyer = [NSUserDefaults boolValueForKey:kIsBuyer];
    [_tableView registerClass:[BookCell class] forCellReuseIdentifier:cellIdentifier];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // Worst performance that just for demo
    _books = [NSMutableArray arrayWithArray:[[BooksDatabase sharedDatabase] getBooks]];
    [_tableView reloadData];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
}

#pragma --mark Public Methods


#pragma --mark UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_books count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BookCell *cell          = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    NSDictionary *_bookInfo = [_books objectAtIndex:indexPath.row];
    cell.bookId             = [_bookInfo objectForKey:kBookId];
    cell.bookName           = [_bookInfo objectForKey:kBookName];
    cell.bookCategory       = [_bookInfo objectForKey:kBookCategory];
    cell.bookPrice          = [_bookInfo objectForKey:kBookPrice];
    cell.selectionStyle     = UITableViewCellSelectionStyleGray;
    cell.accessoryType      = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

#pragma mark UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSDictionary *_bookInfo = [_books objectAtIndex:indexPath.row];
    if( _isBuyer )
    {
        BuyerViewController *_viewController = (BuyerViewController *)[[AppDelegate getAppDelegate] getViewController:[BuyerViewController className]];
        [_viewController setBookId:[_bookInfo objectForKey:kBookId]
                              name:[_bookInfo objectForKey:kBookName]
                          category:[_bookInfo objectForKey:kBookCategory]
                             price:[_bookInfo objectForKey:kBookPrice]];
        _viewController.bookInfo = _bookInfo;
        [self.navigationController pushViewController:_viewController animated:YES];
    }
    else
    {
        SellerViewController *_viewController = (SellerViewController *)[[AppDelegate getAppDelegate] getViewController:[SellerViewController className]];
        [_viewController setBookId:[_bookInfo objectForKey:kBookId]
                              name:[_bookInfo objectForKey:kBookName]
                          category:[_bookInfo objectForKey:kBookCategory]
                             price:[_bookInfo objectForKey:kBookPrice]];
        _viewController.bookInfo = _bookInfo;
        [self.navigationController pushViewController:_viewController animated:YES];
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100.0f;
}

#pragma --mark IBActions
-(IBAction)addBook:(id)sender
{
    SellerViewController *_viewController = (SellerViewController *)[[AppDelegate getAppDelegate] getViewController:[SellerViewController className]];
    _viewController.bookId                = nil;
    [self.navigationController pushViewController:_viewController animated:YES];
}

@end