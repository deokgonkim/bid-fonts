//
//  FavoriteList.m
//  Fonts
//
//  Created by Deokgon Kim on 2018. 6. 2..
//  Copyright © 2018년 Deokgon Kim. All rights reserved.
//

#import "FavoriteList.h"

@interface FavoriteList()

@property (strong, nonatomic) NSMutableArray* favorites;

@end

@implementation FavoriteList

+ (instancetype)sharedInstance {
    static FavoriteList* shared = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shared = [[self alloc] init];
    });
    return shared;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSArray *storedFavorites = [defaults objectForKey:@"favorites"];
        if (storedFavorites) {
            self.favorites = [storedFavorites mutableCopy];
        } else {
            self.favorites = [NSMutableArray array];
        }
    }
    return self;
}

- (void)addFavorite:(id)item {
    [_favorites insertObject:item atIndex:0];
    [self saveFavorites];
}

- (void)removeFavorite:(id)item {
    [_favorites removeObject:item];
    [self saveFavorites];
}

- (void)saveFavorites {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:self.favorites forKey:@"favorites"];
    [defaults synchronize];
}

- (void)moveItemAtIndex:(NSInteger)from toIndex:(NSInteger)to {
    id item = _favorites[from];
    [_favorites removeObjectAtIndex:from];
    [_favorites insertObject:item atIndex:to];
    [self saveFavorites];
}

@end
