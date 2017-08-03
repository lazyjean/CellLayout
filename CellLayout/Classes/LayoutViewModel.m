//
//  

//
//  Created by Jean on 9/13/15.
//  Copyright © 2015 Jean. All rights reserved.
//

#import "LayoutViewModel.h"
#import <ReactiveCocoa/ReactiveCocoa.h>

@implementation LayoutViewModel

- (void)buildLayoutStorage {
    NSAssert(NO, @"子类必须重写buildLayoutStorage方法，返回自己对应的布局信息");
}

#pragma mark - NSCoding
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    
}

- (NSURL *)urlForScheme:(NSString *)scheme storyboardName:(NSString *)storyboardName {
    
    NSAssert(scheme && storyboardName, @"%@ method need address and storyboardName params not nil", NSStringFromSelector(_cmd));
    
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:self];
    NSString *base64Data = [data base64EncodedStringWithOptions:0];
    
    NSURLComponents *components = [[NSURLComponents alloc] init];
    components.scheme = scheme;
    components.host = @"layout";
    
    NSURLQueryItem *nameItem = [[NSURLQueryItem alloc] initWithName:@"storyboard" value:storyboardName];
    NSURLQueryItem *dataItem = [[NSURLQueryItem alloc] initWithName:@"viewModel" value:base64Data];
    components.queryItems = @[nameItem, dataItem];
    
    return components.URL;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

}

- (void)loadData {

}

@end
