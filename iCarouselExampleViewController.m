//
//  iCarouselExampleViewController.m
//  iCarouselExample
//
//  Created by Nick Lockwood on 03/04/2011.
//  Copyright 2011 Charcoal Design. All rights reserved.
//

#import "iCarouselExampleViewController.h"

static int colorValue = 0;

@interface iCarouselExampleViewController ()

@property (nonatomic, strong) UIActivityIndicatorView *pullToRefreshIndicator;

@property (nonatomic, strong) NSMutableArray *items;
@property (nonatomic, assign) BOOL isPullingToRefresh;
@property (nonatomic, assign) BOOL isLoadingMore;

@end


@implementation iCarouselExampleViewController

- (void)awakeFromNib
{
    [super awakeFromNib];

    //set up data
    //your carousel should always be driven by an array of
    //data of some kind - don't store data in your item views
    //or the recycling mechanism will destroy your data once
    //your item views move off-screen
    self.items = [NSMutableArray array];
    for (int i = 0; i < 10; i++)
    {
        [_items addObject:@(i)];
    }
}

- (void)dealloc
{
    //it's a good idea to set these to nil here to avoid
    //sending messages to a deallocated viewcontroller
    //this is true even if your project is using ARC, unless
    //you are targeting iOS 5 as a minimum deployment target
    _carousel.delegate = nil;
    _carousel.dataSource = nil;
}

#pragma mark -
#pragma mark View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //configure carousel
    _carousel.type = iCarouselTypeCoverFlow2;
    _carousel.vertical = YES;

    _pullToRefreshIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [_carousel.contentView addSubview:_pullToRefreshIndicator];
    _pullToRefreshIndicator.center = CGPointMake(_carousel.center.x, _carousel.center.y - 75.f);
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    
    //free up memory by releasing subviews
    self.carousel = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

#pragma mark -
#pragma mark iCarousel methods

- (NSInteger)numberOfItemsInCarousel:(iCarousel *)carousel
{
    //return the total number of items in the carousel
    return [_items count] + 1;
}

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view
{
    if (index == _items.count) {
        UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0, 0, 200.0f, 200.0f)];
        indicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
        [indicator startAnimating];
        return indicator;
    }

    UILabel *label = nil;
    
    //create new view if no view is available for recycling
    if (view == nil || [view isKindOfClass:UIActivityIndicatorView.class])
    {
        //don't do anything specific to the index within
        //this `if (view == nil) {...}` statement because the view will be
        //recycled and used with other index values later
        view = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 200.0f, 200.0f)];
        ((UIImageView *)view).image = [UIImage imageNamed:@"page.png"];
        view.contentMode = UIViewContentModeCenter;
        
        label = [[UILabel alloc] initWithFrame:view.bounds];
        label.backgroundColor = [UIColor clearColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [label.font fontWithSize:50];
        label.tag = 1;
        [view addSubview:label];
    }
    else
    {
        //get a reference to the label in the recycled view
        label = (UILabel *)[view viewWithTag:1];
    }
    
    //set item label
    //remember to always set any properties of your carousel item
    //views outside of the `if (view == nil) {...}` check otherwise
    //you'll get weird issues with carousel item content appearing
    //in the wrong place in the carousel
    label.text = [_items[index] stringValue];
    label.textColor = colorValue % 2 == 0 ? [UIColor redColor] : [UIColor blueColor];
    
    return view;
}

- (CGFloat)carousel:(iCarousel *)carousel valueForOption:(iCarouselOption)option withDefault:(CGFloat)value
{
    if (option == iCarouselOptionSpacing)
    {
        return value * 1.1;
    }
    return value;
}

- (void)carouselDidScroll:(iCarousel *)carousel {
    // Start new pull request when user pulls |carousel|
    // a distance equal to 0.4 width/height of an item
    if (carousel.scrollOffset < -0.4) {
        [self pullToRefresh];
    }

    // Start new load more request when last item will be displayed.
    // In this situation, I ignore cases when |numberOfItems| is small
    // Ex: |numberOfItems| < 2
    if (carousel.scrollOffset > carousel.numberOfItems - 2.1f) {
        [self loadMore];
    }
}

- (void)pullToRefresh {
    // Make sure have only one request at a time
    if (self.isPullingToRefresh) {
        return;
    }

    self.isPullingToRefresh = YES;
    [_pullToRefreshIndicator startAnimating];

    // Request API to receive new data and update |isPullingToRefresh| when request finishes
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.75f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [_items removeAllObjects];

        NSUInteger nextItem = _items.count;
        for (NSUInteger i = nextItem; i < nextItem + 10; i++) {
            [_items addObject:@(i)];
        }

        colorValue++;
        [_carousel reloadData];
        [_pullToRefreshIndicator stopAnimating];
        self.isPullingToRefresh = NO;
    });
}

- (void)loadMore {
    // Make sure have only one request at a time
    if (self.isLoadingMore) {
        return;
    }

    self.isLoadingMore = YES;

    // Request API to receive new data and update |isLoadingMore| when request finishes
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.75f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSUInteger nextItem = _items.count;
        for (NSUInteger i = nextItem; i < nextItem + 10; i++) {
            [_items addObject:@(i)];
            [_carousel insertItemAtIndex:i animated:YES];
        }
        self.isLoadingMore = NO;
    });
}

@end
