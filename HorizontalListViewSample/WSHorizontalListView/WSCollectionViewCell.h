//
//  WSCollectionViewCell.h
//  HorizontalListViewSample
//
//  Created by shlity on 16/7/26.
//  Copyright © 2016年 Moresing Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WSCollectionViewCell : UICollectionViewCell

@property (nonatomic,strong)UILabel                 *goodsNameLabel;
@property (nonatomic,strong)UIImageView             *goodsImageView;

- (void)configureCellWithInfo:(NSDictionary *)data;

@end
