//
//  ViewControllerB.m
//  TestDemo
//
//  Created by Ben on 2016/12/19.
//  Copyright © 2016年 Ben. All rights reserved.
//

#import "ViewControllerB.h"
#import "TableViewCell.h"

@interface ViewControllerB () <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UIView *customView;
@property (weak, nonatomic) IBOutlet UILabel *labelB;

@end

@implementation ViewControllerB

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
//    CGSize size = [self.customView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
//    NSLog (@"size: %@", NSStringFromCGSize(size));
//    
//    CGRect screenBounds = [UIScreen mainScreen].bounds;
//    self.customView.frame = CGRectMake(0, 300, screenBounds.size.width, screenBounds.size.height);
//    [self.view addSubview:self.customView];
//    
//    TableViewCell *cell = [[[NSBundle mainBundle] loadNibNamed:@"TableViewCell" owner:nil options:nil] objectAtIndex:0];
//    CGRect cellFrame = cell.frame;
//    cellFrame.size.width = screenBounds.size.width;
//    cell.frame = cellFrame;
//    CGSize cellSize = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
//    NSLog (@"cell size: %@", NSStringFromCGSize(cellSize));
//    NSLog (@"cell frame: %@", NSStringFromCGRect(cell.frame));
//
//    [self.view addSubview:cell];
}

#pragma mark - 

- (NSInteger)numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 114;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    TableViewCell *cell = [[[NSBundle mainBundle] loadNibNamed:@"TableViewCell" owner:nil options:nil] objectAtIndex:0];
//    CGSize cellSize = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
//    NSLog (@"cell size: %@", NSStringFromCGSize(cellSize));
//    NSLog (@"cell frame: %@", NSStringFromCGRect(cell.frame));
    
    return cell;
}

@end
