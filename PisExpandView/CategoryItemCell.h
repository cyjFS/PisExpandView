//
//  CategoryItemCell.h
//  PisExpandView
//
//  Created by newegg on 15/7/23.
//  Copyright (c) 2015年 newegg. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CategoryItemInfo;

@interface CategoryItemCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel  *categoryName;


@property (nonatomic,assign)BOOL              showIcon;

- (void)bindData:(CategoryItemInfo *)itemData;

+(CGFloat)cellHeight;
@end
