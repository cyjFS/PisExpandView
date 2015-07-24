//
//  CategoryItemCell.m
//  PisExpandView
//
//  Created by newegg on 15/7/23.
//  Copyright (c) 2015年 newegg. All rights reserved.
//

#import "CategoryItemCell.h"
#import "CategoryItemInfo.h"
#define kIconSize 50

@interface CategoryItemCell()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftGap;
@property (weak, nonatomic) IBOutlet UIImageView *iconImage;

@end

@implementation CategoryItemCell
{
    UIView      *selectedBgView;
}

- (void)awakeFromNib {
    _showIcon = NO;
    self.exclusiveTouch = YES;
    
    selectedBgView = [[UIView alloc] init];
    selectedBgView.backgroundColor = [UIColor colorWithRed:232.0/255.0 green:232.0/255.0 blue:232.0/255.0 alpha:1.0];
    self.selectedBackgroundView = selectedBgView;
}

- (void)setShowIcon:(BOOL)showIcon
{
    _showIcon = showIcon;
    
    if (showIcon) {
        self.iconImage.hidden = NO;
        self.leftGap.constant = 55.0f;
        self.categoryName.font = [UIFont systemFontOfSize:15.0f];
    }else
    {
        self.iconImage.hidden = YES;
        self.leftGap.constant = 15.0;
        self.categoryName.font = [UIFont systemFontOfSize:14.0];
    }
}

- (void)bindData:(CategoryItemInfo *)itemData
{
    if (self.showIcon) {
        self.iconImage.image = [UIImage imageNamed:[NSString stringWithFormat:@"%ld.png",(long)itemData.CatID]];
        
    }
    self.categoryName.text = itemData.CatName;
}


+ (CGFloat)cellHeight
{
    return 50.0f;
}


@end
