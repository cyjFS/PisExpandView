//
//  CategoryItemInfo.m
//  PisExpandView
//
//  Created by newegg on 15/7/23.
//  Copyright (c) 2015年 newegg. All rights reserved.
//

#import "CategoryItemInfo.h"
#import <objc/runtime.h>
#define kItemType @"__ItemType"

@implementation CategoryItemInfo
- (id)init
{
    if (self = [super init]) {
        self.subCategories = [self arrayWithItemType:[CategoryItemInfo class]];
    }
    return self;
}

- (id)arrayWithItemType:(Class)itemType
{
    NSMutableArray *array = [NSMutableArray array];
    objc_setAssociatedObject(array, kItemType, itemType, OBJC_ASSOCIATION_ASSIGN);
    return array;
}
@end
