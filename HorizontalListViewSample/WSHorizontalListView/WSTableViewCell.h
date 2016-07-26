//
//  WSTableViewCell.h
//  HorizontalListViewSample
//
//  Created by shlity on 16/7/26.
//  Copyright © 2016年 Moresing Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WSCollectionViewCell.h"

@interface WSCollectionView : UICollectionView

@property (nonatomic, strong) NSIndexPath *indexPath;

@end

static NSString *CollectionViewCellIdentifier = @"CollectionViewCellIdentifier";

@interface WSTableViewCell : UITableViewCell

@property (nonatomic,strong)WSCollectionView    *collectionView;
@property (nonatomic,strong)UIImageView         *itemImageView;
@property (nonatomic,strong)UILabel             *contentLabel;

- (void)setCollectionViewDataSourceDelegate:(id<UICollectionViewDataSource, UICollectionViewDelegate>)dataSourceDelegate indexPath:(NSIndexPath *)indexPath;

- (void)configureCellWithInfo:(NSDictionary *)data;

@end
