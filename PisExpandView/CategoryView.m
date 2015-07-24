//
//  CategoryView.m
//  PisExpandView
//
//  Created by newegg on 15/7/23.
//  Copyright (c) 2015年 newegg. All rights reserved.
//

#import "CategoryView.h"
#import "CategoryItemInfo.h"
#import "CategoryItemCell.h"
@interface CategoryView()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong)NSArray    *categoryList;

@end
@implementation CategoryView
+(id)viewFromXib {
    Class cellClass = [self class];
    NSString *cellClassName = NSStringFromClass(cellClass);
    NSArray *nibArray = [[NSBundle mainBundle] loadNibNamed:cellClassName owner:nil options:nil];
    for (NSObject *item in nibArray) {
        if ([item isMemberOfClass:cellClass]) {
            return item;
        }
    }
    return nil;
}

- (void)awakeFromNib
{
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    NSString *className = NSStringFromClass([CategoryItemCell class]);
    UINib *nib = [UINib nibWithNibName:className bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:className];
}


#pragma mark - Properties

- (void)setCategoryItem:(CategoryItemInfo *)categoryItem
{
    [self setCategoryItem:categoryItem animated:YES];
}

- (void)setCategoryItem:(CategoryItemInfo *)categoryItem animated:(BOOL)animated
{
    if (_categoryItem != categoryItem) {
        _categoryItem = categoryItem;
    
    
        self.categoryList = [NSArray arrayWithArray:categoryItem.subCategories];
        
        if (animated) {
            [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationRight];
        }else
        {
            [self.tableView reloadData];
        }
    }
}


#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.categoryList count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CategoryItemCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([CategoryItemCell class])];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectedBackgroundView.backgroundColor = self.selectedBgColor;
    cell.showIcon = self.showCategoryIcon;
    
    if (self.categoryNameColor) {
        cell.categoryName.textColor = self.categoryNameColor;
    }
    
    [cell bindData:self.categoryList[indexPath.row]];
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.delegate respondsToSelector:@selector(CategoryView:didSelectCategoryItem:)]) {
        [self.delegate CategoryView:self didSelectCategoryItem:self.categoryList[indexPath.row]];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [CategoryItemCell cellHeight];
}

@end
