//
//  ViewController.m
//  TouchingStatusBarEffect
//
//  Created by Trung Duc on 7/14/18.
//  Copyright © 2018 Trung Duc. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *btnUp;

@property (nonatomic, strong) UISearchController *searchController;

@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view, typically from a nib.

  self.title = @"Status Bar Effect";

  self.navigationController.navigationBar.prefersLargeTitles = YES;

  _searchController = [[UISearchController alloc] initWithSearchResultsController:self];
  self.navigationItem.searchController = _searchController;
  self.navigationItem.hidesSearchBarWhenScrolling = YES;

  [self configureTableView];
  [self configureGoUpButton];
}

- (void)configureTableView {
  self.tableView.delegate = self;
  self.tableView.dataSource = self;
  self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
  [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
}

- (void)configureGoUpButton {
  self.btnUp.layer.cornerRadius = 25.f;
  self.btnUp.layer.shadowOffset = CGSizeMake(1.f, 1.f);
  self.btnUp.layer.shadowColor = [UIColor lightGrayColor].CGColor;
  self.btnUp.layer.shadowOpacity = 0.5f;
}

- (IBAction)btnUpDidTouch:(id)sender {
  [UIView animateWithDuration:0.25f animations:^{
    [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:NO];
  } completion:^(BOOL finished) {
    [UIView animateWithDuration:0.25f animations:^{
      self.navigationItem.hidesSearchBarWhenScrolling = NO;
      self.navigationItem.largeTitleDisplayMode = UINavigationItemLargeTitleDisplayModeAlways;
    } completion:^(BOOL finished) {
      self.navigationItem.hidesSearchBarWhenScrolling = YES;
      self.navigationItem.largeTitleDisplayMode = UINavigationItemLargeTitleDisplayModeAutomatic;
    }];
  }];
}
#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return 200;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];

  CGFloat whiteColor = indexPath.row % 2 == 0 ? 1.f : 0.9f;
  cell.backgroundColor = [UIColor colorWithWhite:whiteColor alpha:1.f];
  cell.textLabel.text = [NSString stringWithFormat:@"%ld", indexPath.row];

  return cell;
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}


@end
