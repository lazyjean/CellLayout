//
//  DemoViewController.m
//  CellLayoutSample
//
//  Created by 刘 真 on 3/3/16.
//  Copyright © 2016 Liu Zhen. All rights reserved.
//

#import "DemoViewController.h"
#import "LayoutViewModel.h"
#import "LayoutController.h"
#import "DemoViewModel.h"

@interface DemoViewController ()

@end

@implementation DemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)showDynamicTable:(id)sender {
    DemoViewModel *model = [[DemoViewModel alloc] init];
    NSURL *url = [model urlForScheme:@"demo" storyboardName:@"myboard"];
    NSLog(@"%@", url);
    LayoutController *controller = [LayoutController instantiateWithStoryboardName:@"Table" viewModel:model];
    [self.navigationController pushViewController:controller animated:YES];
}

@end
