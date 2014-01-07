//
//  ZTriViewController.m
//
//  Created by Ayal Spitz on 12/22/13.
//  Copyright (c) 2014 Ayal Spitz. All rights reserved.
//

#import "ZTriViewController.h"
#import "UIView+Constraints.h"

@interface ZTriViewCell : UICollectionViewCell
@property (nonatomic, strong) UIViewController *viewController;

+ (instancetype)cell;

- (void)addViewControllerView;
- (void)removeViewControllerView;

@end


@interface ZTriViewController () <UICollectionViewDataSource, UICollectionViewDelegate>
@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) NSMutableArray *cells;
@property (nonatomic, strong) NSMutableArray *viewControllers;
@property (nonatomic, assign) TriViewPosition previousPosition;
@property (nonatomic, assign) TriViewPosition currentPosition;

@property (nonatomic, assign) BOOL startingPosition;
@end

@implementation ZTriViewController

#pragma mark - Initialization methods

- (instancetype)init{
    self = [super init];
    if (self) {
        self.view.translatesAutoresizingMaskIntoConstraints = NO;
        self.view.backgroundColor = [UIColor lightGrayColor];
    }
    return self;
}

+ (instancetype)triViewController{
    return [[[self class]alloc]init];
}

#pragma mark - View methods

- (void)viewDidLoad{
    [super viewDidLoad];
    
    self.startingPosition = YES;
    
    self.cells = [NSMutableArray arrayWithArray:@[[NSNull null], [NSNull null], [NSNull null]]];
    self.viewControllers = [NSMutableArray arrayWithArray:@[[NSNull null], [NSNull null], [NSNull null]]];
    
    UICollectionViewFlowLayout *collectionViewLayout = [[UICollectionViewFlowLayout alloc]init];
    collectionViewLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    collectionViewLayout.minimumInteritemSpacing = 0.0;
    collectionViewLayout.minimumLineSpacing = 0.0;
    
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:collectionViewLayout];
    self.collectionView.translatesAutoresizingMaskIntoConstraints = NO;
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    self.collectionView.scrollEnabled = NO;
    [self.view addSubview:self.collectionView];
    
    for (NSUInteger i=0;i<3;i++){
        NSString *cellReuseId = [NSString stringWithFormat:@"TRIVIEWCELL_%d", i];
        [self.collectionView registerClass:[ZTriViewCell class] forCellWithReuseIdentifier:cellReuseId];
    }
    
    [self.view addFullViewConstraints:self.collectionView];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    [self scrollTo:TriViewPrimaryPosition animated:NO];
}

#pragma mark -

- (void)scrollTo:(TriViewPosition)triViewPosition animated:(BOOL)animated{
    UIViewController *viewController = self.viewControllers[triViewPosition];
    
    if (![viewController isKindOfClass:[NSNull class]]){
        self.previousPosition = self.currentPosition;
        self.currentPosition = triViewPosition;

        UIViewController *previousViewController = self.viewControllers[self.previousPosition];
        UIViewController *currentViewController = self.viewControllers[self.currentPosition];
        [previousViewController willMoveToParentViewController:nil];
        [self addChildViewController:currentViewController];
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:self.currentPosition inSection:0];
        [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:animated];
    }
}

#pragma mark -
- (void)setViewController:(UIViewController *)viewController forPosition:(TriViewPosition)position{
    self.viewControllers[position] = viewController;
}

- (UIViewController *)viewControllerForPosition:(TriViewPosition)position{
    return self.viewControllers[position];
}

#pragma mark - UICollectionViewDataSource methods

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.cells.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    NSString *cellId = [NSString stringWithFormat:@"TRIVIEWCELL_%d", indexPath.row];
    
    ZTriViewCell *cell = self.cells[indexPath.row];
    if ([cell isKindOfClass:[NSNull class]]){
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
        self.cells[indexPath.row] = cell;
    }
    
    if (self.startingPosition){
        self.startingPosition = NO;
    } else {
        UIViewController *viewController = self.viewControllers[indexPath.row];
        if (![viewController isKindOfClass:[NSNull class]]){
            cell.viewController = viewController;
            [cell addViewControllerView];
            [viewController didMoveToParentViewController:self];
        }
    }
    
    return cell;
}

#pragma mark - UICollectionViewDelegate methods
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return collectionView.frame.size;
}

- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath{
    ZTriViewCell *previousCell = self.cells[self.previousPosition];
    UIViewController *previousViewController = self.viewControllers[self.previousPosition];
    UIViewController *currentViewController = self.viewControllers[self.currentPosition];

    [previousViewController willMoveToParentViewController:nil];
    [previousCell removeViewControllerView];
    [previousViewController removeFromParentViewController];
    [currentViewController didMoveToParentViewController:self];
}

@end



@implementation ZTriViewCell

+ (instancetype)cell{
    return [[ZTriViewCell alloc]initWithFrame:CGRectZero];
}

- (void)addViewControllerView{
    self.viewController.view.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:self.viewController.view];
    
    [self addFullViewConstraints:self.viewController.view];
    [self layoutIfNeeded];
}

- (void)removeViewControllerView{
    [self.viewController.view removeFromSuperview];
}

@end
