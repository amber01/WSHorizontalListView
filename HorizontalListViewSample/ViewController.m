//
//  ViewController.m
//  HorizontalListViewSample
//
//  Created by shlity on 16/7/26.
//  Copyright © 2016年 Moresing Inc. All rights reserved.
//

#import "ViewController.h"
#import "WSTableViewCell.h"
#import "WSCollectionViewCell.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource,UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic,strong)NSMutableArray      *dataArray;
@property (nonatomic,strong)NSMutableDictionary *contentOffsetDictionary;

@property (nonatomic,strong)UITableView  *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"Detail";
    
    NSMutableArray *tempArray = [NSMutableArray array];
    
    for (int i = 0; i < 10; i ++) {
        
        NSString *imageName = [NSString stringWithFormat:@"00%d.png",i + 1];
        
        NSString *contentStr = [NSString stringWithFormat:@"The best preparation for tomorrow is doing your best today. current row %d",i + 1];
        
        NSString *goodsImageName = [NSString stringWithFormat:@"a%d.jpg",i + 1];
        
        [tempArray addObject:@{@"imageName":goodsImageName,@"goodsName":[NSString stringWithFormat:@"default  name ：%d",i + 1]}];
        
        if (!_dataArray) {
            
            _dataArray = [[NSMutableArray alloc]init];
            
        }
        
        [_dataArray addObject:@{@"imageName":imageName,@"content":contentStr,@"goods":tempArray}];
    }
    
    NSLog(@"dataArray:%@",_dataArray);
    
    [self.view addSubview:self.tableView];
    
}

#pragma mark -- UI
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = NO;
    }
    return _tableView;
}

#pragma mark -- UITableViewDelegate
#pragma mark -- UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CellIdentifier";
    
    WSTableViewCell *cell = (WSTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell)
    {
        cell = [[WSTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    NSDictionary *dic = self.dataArray[indexPath.row];
    
    
    [cell configureCellWithInfo:@{@"content":[dic objectForKey:@"content"],@"imageName":[dic objectForKey:@"imageName"]}];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(WSTableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [cell setCollectionViewDataSourceDelegate:self indexPath:indexPath];
    NSInteger index = cell.collectionView.indexPath.row;
    
    CGFloat horizontalOffset = [self.contentOffsetDictionary[[@(index) stringValue]] floatValue];
    [cell.collectionView setContentOffset:CGPointMake(horizontalOffset, 0)];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat tempImageWith = [UIScreen mainScreen].bounds.size.width / 640;
    CGFloat tempHeight = 480 * tempImageWith;
    
    return tempHeight + 215;
}


#pragma mark - UICollectionViewDataSource Methods

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSArray *collectionViewArray = [self.dataArray[[(WSCollectionView *)collectionView indexPath].row]objectForKey:@"goods"];
    return collectionViewArray.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    WSCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CollectionViewCellIdentifier forIndexPath:indexPath];
    
    NSArray *collectionViewArray = [self.dataArray[[(WSCollectionView *)collectionView indexPath].item]objectForKey:@"goods"];
    
    NSDictionary *dic = [collectionViewArray objectAtIndex:indexPath.row];
    
    [cell configureCellWithInfo:dic];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger section = [(WSCollectionView *)collectionView indexPath].row;
    NSLog(@"section:%ld row%ld",section,indexPath.row);
}


#pragma mark - UIScrollViewDelegate Methods

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    if (![scrollView isKindOfClass:[UICollectionView class]]) return;
    
    CGFloat horizontalOffset = scrollView.contentOffset.x;
    
    WSCollectionView *collectionView = (WSCollectionView *)scrollView;
    NSInteger index = collectionView.indexPath.row;
    self.contentOffsetDictionary[[@(index) stringValue]] = @(horizontalOffset);
}


#pragma mark -- other
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
