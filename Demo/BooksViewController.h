//
//  SellerViewController.h
// 
//
//  Created by Kalvar Lin on 2015/8/28.
//  Copyright (c) 2015年 Kuo-Ming Lin. All rights reserved.
//

@interface BooksViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, weak) IBOutlet UIBarButtonItem *barItem;
@property (nonatomic, strong) NSMutableArray *books;

-(IBAction)addBook:(id)sender;

@end
