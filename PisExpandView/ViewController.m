//
//  ViewController.m
//  PisExpandView
//
//  Created by newegg on 15/7/23.
//  Copyright (c) 2015年 newegg. All rights reserved.
//

#import "ViewController.h"
#import "CategoryView.h"
#import "CategoryItemInfo.h"

#define kAnimationDuration 0.25
#define kHeightStatusBar 20.0f
#define kHeightNavigationBar 44.0f
#define kHeightStatusNavigationBar (kHeightStatusBar + kHeightNavigationBar)
#define screen_w [[UIScreen mainScreen] bounds].size.width
#define RGBCOLOR(r,g,b)     [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
#define NE_FORECOLOR_DARK_GRAY  RGBCOLOR(127, 127, 127)
#define NE_FORECOLOR_BLACK      RGBCOLOR(34, 34, 34)

@interface ViewController () <CategoryViewDelegate>

@property (nonatomic, strong) CategoryView           *category1View;
@property (nonatomic, strong) CategoryView           *category2View;
@property (nonatomic, strong) CategoryView           *category3View;
@property (nonatomic, strong) NSMutableArray                *storedCatAll;

@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"分类浏览";
    
    CategoryView *categoryView = [self createCategoryView:CategoryLevel1];
    
    [self.view addSubview:categoryView];
    
    self.category1View = categoryView;
    [self configArr];
    
}

- (void)configArr
{
    self.storedCatAll = [NSMutableArray array];
    NSMutableArray *storedCat2 = [NSMutableArray array];
    NSMutableArray *storedCat3 = [NSMutableArray array];
    
    for (int i = 0; i < 12; i++) {
        CategoryItemInfo *categoryItemInfo1 = [[CategoryItemInfo alloc] init];
        categoryItemInfo1.CatName = [NSString stringWithFormat:@"(%d)",i+1];
        categoryItemInfo1.CatID = i+1;
        
        for (int j = 0; j < (arc4random()%12 + 1); j++) {
            CategoryItemInfo *categoryItemInfo2 = [[CategoryItemInfo alloc] init];
            categoryItemInfo2.CatName = [NSString stringWithFormat:@"(%d,%d)",i+1,j+1];
            categoryItemInfo2.CatID = j+1;
            
            for (int k = 0; k < (arc4random()%12 + 1); k++) {
                CategoryItemInfo *categoryItemInfo3 = [[CategoryItemInfo alloc] init];
                categoryItemInfo3.CatName = [NSString stringWithFormat:@"(%d,%d,%d)",i+1,j+1,k+1];
                categoryItemInfo3.CatID = k+1;
                [storedCat3 addObject:categoryItemInfo3];
            }

            categoryItemInfo2.subCategories = [storedCat3 copy];
            [storedCat3 removeAllObjects];
            [storedCat2 addObject:categoryItemInfo2];
        }
        categoryItemInfo1.subCategories = [storedCat2 copy];
        [storedCat2 removeAllObjects];
        [self.storedCatAll addObject:categoryItemInfo1];
    }
    
    [self bindTopCategoryData:self.storedCatAll];
}

- (void)bindTopCategoryData:(NSArray *)categories
{
    CategoryItemInfo *categoryItem = [[CategoryItemInfo alloc] init];
    
    categoryItem.CatID = 0;
    categoryItem.CatName = @"";
    categoryItem.subCategories = categories;
    
    NSIndexPath *selectedIndex = [self.category1View.tableView indexPathForSelectedRow];
    
    [self.category1View setCategoryItem:categoryItem animated:NO];
    
    if (selectedIndex.section >= 0 && selectedIndex.section < [self.category1View.tableView numberOfSections]) {
        if (selectedIndex.row >= 0 && selectedIndex.row < [self.category1View.tableView numberOfRowsInSection:selectedIndex.section]) {
            [self.category1View.tableView selectRowAtIndexPath:selectedIndex animated:NO scrollPosition:UITableViewScrollPositionNone];
        }
    }
}

- (CategoryView *)createCategoryView:(CategoryLevel)categoryLevel
{
    CategoryView *categoryView = [CategoryView viewFromXib];
    categoryView.categoryLevel = categoryLevel;
    categoryView.delegate = self;
    
    
    switch (categoryLevel) {
        case CategoryLevel1:
        {
            categoryView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
            categoryView.backgroundColor = RGBCOLOR(255, 255, 255);
            categoryView.selectedBgColor = RGBCOLOR(241, 241, 241);
            categoryView.showCategoryIcon = YES;
        }
            break;
        case CategoryLevel2:
        {
            categoryView.frame = CGRectMake(self.view.frame.size.width, 0, 143*screen_w/320, self.view.frame.size.height);
            categoryView.backgroundColor = RGBCOLOR(241, 241, 241);
            categoryView.selectedBgColor = RGBCOLOR(232, 232, 232);
            
            UIEdgeInsets edgeInsets = UIEdgeInsetsMake(kHeightStatusNavigationBar, 0, 0, 0.0f);
            categoryView.tableView.contentInset = edgeInsets;
        }
            break;
        case CategoryLevel3:
        {
            categoryView.frame = CGRectMake(self.view.frame.size.width, 0, 168*screen_w/320, self.view.frame.size.height);
            categoryView.backgroundColor = RGBCOLOR(232, 232, 232);
            categoryView.selectedBgColor = RGBCOLOR(223, 223, 223);
            
            UIEdgeInsets edgeInsets = UIEdgeInsetsMake(kHeightStatusNavigationBar, 0, 0, 0.0f);
            categoryView.tableView.contentInset = edgeInsets;
        }
            break;
        default:
            break;
    }
    return categoryView;
}

#pragma mark - CategoryViewDelegate

- (void)CategoryView:(CategoryView *)categoryView didSelectCategoryItem:(CategoryItemInfo *)categoryItem
{
    if (!([categoryItem.subCategories count] > 0)) {
        
    }else if (categoryView.categoryLevel == CategoryLevel1) {
        [self exchangeCategory2:categoryItem];
    }else if (categoryView.categoryLevel == CategoryLevel2) {
        [self exchangeCategory3:categoryItem];
    }
}

#pragma mark - Utility Methods

- (void)exchangeCategory2:(CategoryItemInfo *)categoryItem
{
    if (self.category2View == nil) {
        self.category1View.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        CategoryView *categoryView = [self createCategoryView:CategoryLevel2];
        [self.view addSubview:categoryView];
        
        categoryView.categoryItem = categoryItem;
        self.category2View = categoryView;
        
        [self changeCategoryNameColor:NE_FORECOLOR_DARK_GRAY ofCategoryView:self.category1View];
        
        [UIView animateWithDuration:kAnimationDuration animations:^{
            self.category2View.frame = CGRectMake(self.view.frame.size.width - self.category2View.frame.size.width, self.category2View.frame.origin.y, self.category2View.frame.size.width, self.category2View.frame.size.height);
        }];
    }
    
    self.category2View.categoryNameColor = NE_FORECOLOR_BLACK;
    self.category2View.categoryItem = categoryItem;
    
    [self dismissCategory3View];
}

- (void)exchangeCategory3:(CategoryItemInfo *)categoryItem
{
    if (self.category3View == nil) {
        CategoryView *categoryView = [self createCategoryView:CategoryLevel3];
        [self.view addSubview:categoryView];
        
        categoryView.categoryItem = categoryItem;
        self.category3View = categoryView;
        
        [self changeCategoryNameColor:NE_FORECOLOR_DARK_GRAY ofCategoryView:self.category2View];
        
        [UIView animateWithDuration:kAnimationDuration animations:^{
            self.category3View.frame = CGRectMake(self.view.frame.size.width - self.category3View.frame.size.width, self.category3View.frame.origin.y, self.category3View.frame.size.width, self.category3View.frame.size.height);
            
            self.category2View.frame = CGRectMake(55, self.category2View.frame.origin.y, self.category2View.frame.size.width, self.category2View.frame.size.height);
            
            self.category2View.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        }];
    }
    self.category3View.categoryItem = categoryItem;
}

- (void)changeCategoryNameColor:(UIColor *)nameColor ofCategoryView:(CategoryView *)categoryView
{
    categoryView.categoryNameColor = nameColor;
    
    [self reloadCategoryView:categoryView];
}

- (void)reloadCategoryView:(CategoryView *)categoryView
{
    NSIndexPath *indexPath = [categoryView.tableView indexPathForSelectedRow];
    [categoryView.tableView reloadData];
    [categoryView.tableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
}

- (void)dismissCategory3View
{
    self.category2View.categoryNameColor = NE_FORECOLOR_BLACK;
    
    if (self.category3View) {
        self.category2View.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        
        [UIView animateWithDuration:kAnimationDuration animations:^{
            self.category3View.frame = CGRectMake(self.view.frame.size.width, self.category3View.frame.origin.y, self.category3View.frame.size.width, self.category3View.frame.size.height);
            
            self.category2View.frame = CGRectMake(self.view.frame.size.width - self.category2View.frame.size.width, self.category2View.frame.origin.y, self.category2View.frame.size.width, self.category2View.frame.size.height);
            
        } completion:^(BOOL finished) {
            [self.category3View removeFromSuperview];
            self.category3View = nil;
        }];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
