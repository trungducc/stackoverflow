//
//  ViewController.m
//  DemoCollecitonView
//
//  Created by Trung Duc on 10/31/17.
//  Copyright © 2017 Trung Duc. All rights reserved.
//

#import "ViewController.h"

const CGFloat kPadding                         = 5.f;
const NSUInteger kNumberSmallCellALine         = 2;

@interface CustomCollectionViewLayout : UICollectionViewLayout

@property (nonatomic, strong) NSMutableArray *layoutAttributes;
@property (nonatomic, assign) CGFloat contentHeight;

@end

@implementation CustomCollectionViewLayout

// Use this method to perform the up-front calculations needed to provide layout information.
- (void)prepareLayout{
  [super prepareLayout];

  if (!self.layoutAttributes){
    self.layoutAttributes = [[NSMutableArray alloc] init];

    // Calculate width of each item
    CGFloat cellWidth = (self.collectionView.frame.size.width - (kNumberSmallCellALine - 1) * kPadding) / kNumberSmallCellALine;
    // Default height of contentSize
    self.contentHeight = 0.f;
    // Height of column items on the left
    CGFloat leftColumnHeight = 0.f;
    // Height of column items on the right
    CGFloat rightColumnHeight = 0.f;

    for (int i = 0 ; i < [self.collectionView numberOfItemsInSection:0] ; i ++){

      // Height of item at index i
      CGFloat height = i * 20 + 20;

      CGFloat xPos, yPos = 0.f;

      if (i % 2 == 0) {
        // If item on the right
        xPos = 0.f;
        yPos = leftColumnHeight;
        leftColumnHeight += height + kPadding;
      } else {
        // Item on the left
        xPos = cellWidth + kPadding;
        yPos = rightColumnHeight;
        rightColumnHeight += height + kPadding;
      }

      // Update height of contentSize after adding new item
      self.contentHeight = MAX(leftColumnHeight, rightColumnHeight);

      UICollectionViewLayoutAttributes *attr = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
      attr.frame = CGRectMake(xPos,
                              yPos,
                              cellWidth,
                              height);
      [self.layoutAttributes addObject:attr];
    }
  }
}

// Use this method to return the attributes for cells and views that are in the specified rectangle.
- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect{
  NSMutableArray *currentAttributes = [NSMutableArray new];
  for (UICollectionViewLayoutAttributes *attr in self.layoutAttributes) {
    if (CGRectIntersectsRect(attr.frame, rect))
    {
      [currentAttributes addObject:attr];
    }
  }
  return currentAttributes;
}

// Use this method to return the overall size of the entire content area based on your initial calculations.
- (CGSize)collectionViewContentSize{
  return CGSizeMake(self.collectionView.frame.size.width, self.contentHeight);
}

@end

@interface ViewController () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view, typically from a nib.
  self.collectionView.dataSource = self;
  [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
  CustomCollectionViewLayout *layout = [[CustomCollectionViewLayout alloc] init];
  [self.collectionView setCollectionViewLayout:layout];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
  return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
  return 20;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
  UICollectionViewCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];

  cell.contentView.backgroundColor = UIColor.redColor;

  return cell;
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}


@end
