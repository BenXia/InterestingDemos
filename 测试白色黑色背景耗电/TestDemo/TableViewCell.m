//
//  TableViewCell.m
//  TestDemo
//
//  Created by Ben on 2016/12/19.
//  Copyright © 2016年 Ben. All rights reserved.
//

#import "TableViewCell.h"

@interface TableViewCell ()

@end

@implementation TableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
//    CGRect contentViewFrame = self.contentView.frame;
//    contentViewFrame.size.width = [UIScreen mainScreen].bounds.size.width;
//    
//    self.contentView.frame = contentViewFrame;
    
//    NSLayoutConstraint *widthFenceConstraint = [NSLayoutConstraint constraintWithItem:self.contentView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:[UIScreen mainScreen].bounds.size.width];
//    [self.contentView addConstraint:widthFenceConstraint];
    
    CGSize cellSize = [self.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    NSLog (@"cell size: %@", NSStringFromCGSize(cellSize));
    NSLog (@"cell frame: %@", NSStringFromCGRect(self.frame));
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
