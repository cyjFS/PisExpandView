//
//  CategoryItemInfo.h
//  PisExpandView
//
//  Created by newegg on 15/7/23.
//  Copyright (c) 2015年 newegg. All rights reserved.
//

#import <Foundation/Foundation.h>
#define kCategoryNameAllCategoryItems @"查看所有商品"
@interface CategoryItemInfo : NSObject

@property (nonatomic,assign)NSInteger         CatID;
@property (nonatomic,strong)NSString          *CatName;
@property (nonatomic,strong)NSArray           *subCategories;

/*!
 * 当CatName为“查看所有商品”时，此处保存上级分类的CatName
 */
@property (nonatomic, strong) NSString          *xRealCatName;
@end
