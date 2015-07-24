//
//  CategoryView.h
//  PisExpandView
//
//  Created by newegg on 15/7/23.
//  Copyright (c) 2015年 newegg. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CategoryItemInfo;
@class CategoryView;
@protocol CategoryViewDelegate <NSObject>

@optional
- (void)CategoryView:(CategoryView *)categoryView didSelectCategoryItem:(CategoryItemInfo *)categoryItem;

@end

typedef enum {
    CategoryLevelNone = 0,
    CategoryLevel1 = 1,
    CategoryLevel2 = 2,
    CategoryLevel3 = 3
} CategoryLevel;
@interface CategoryView : UIView

@property (weak, nonatomic) IBOutlet UITableView        *tableView;
@property (nonatomic, weak) id <CategoryViewDelegate>   delegate;

@property (nonatomic,strong)CategoryItemInfo            *categoryItem;
@property (nonatomic,assign)CategoryLevel               categoryLevel;
@property (nonatomic,strong)UIColor                     *categoryNameColor;
@property (nonatomic,strong)UIColor                     *selectedBgColor;
@property (nonatomic,assign)BOOL                        showCategoryIcon;

- (void)setCategoryItem:(CategoryItemInfo *)categoryItem animated:(BOOL)animated;

+ (id)viewFromXib;

@end
