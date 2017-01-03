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

- (IBAction)showDynamicTable:(id)sender {
    DemoViewModel *model = [[DemoViewModel alloc] init];
    NSURL *url = [model urlForScheme:@"demo" storyboardName:@"Table"];
    NSLog(@"url is %@", url);
    LayoutController *controller = [LayoutController instantiateWithStoryboardName:@"Table" viewModel:model];
    [self.navigationController pushViewController:controller animated:YES];
}

@end
