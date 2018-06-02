//
//  FavoriteList.h
//  Fonts
//
//  Created by Deokgon Kim on 2018. 6. 2..
//  Copyright © 2018년 Deokgon Kim. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FavoriteList : NSObject

+ (instancetype)sharedInstance;

- (NSArray *)favorites;

- (void)addFavorite:(id)item;
- (void)removeFavorite:(id)item;

@end
