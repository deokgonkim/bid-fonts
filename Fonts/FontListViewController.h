//
//  FontListViewController.h
//  Fonts
//
//  Created by Deokgon Kim on 2018. 6. 2..
//  Copyright © 2018년 Deokgon Kim. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FontListViewController : UITableViewController <UITableViewDataSource, UITableViewDelegate>

@property (copy, nonatomic) NSArray *fontNames;
@property (assign, nonatomic) BOOL showsFavorites;

@end
