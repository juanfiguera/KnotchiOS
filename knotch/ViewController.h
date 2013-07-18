//
//  ViewController.h
//  knotch
//
//  Created by Juan Figuera on 7/14/13.
//  Copyright (c) 2013 Juan Figuera. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFNetworking.h"
#import "UIImageView+AFNetworking.h"

// Adding delegates for UITableView
@interface ViewController : UIViewController < UITableViewDelegate, UITableViewDataSource >


@property (retain, nonatomic) IBOutlet UILabel *nameTopLabel;


@property (retain, nonatomic) IBOutlet UITableView *tableView;


- (UIColor *) colorWithHexString: (NSString *) stringToConvert;


@end
