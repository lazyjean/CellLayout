//
//  ViewController.h

//
//  Created by Jean on 9/12/15.
//  Copyright © 2015 Jean. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LayoutViewModel;

@interface LayoutController : UITableViewController

/**
 *  如果用户需要多种的header和footer的类型，那么可以在storyboard上面将准备好的view关联到这里，然后在TableHeader里面，设置好类名，则会将第一个发现的Header填上去，Footer同理
 */
@property (strong, nonatomic) IBOutletCollection(UIView) NSArray *viewsPool;

/**
 *  构造一个LayoutController对象
 *
 *  @param storyboardName storyboard的名字
 *  @param viewModel      viewModel对象
 *
 *  @return LayoutController对象
 */
+ (instancetype)instantiateWithStoryboardName:(NSString *)storyboardName viewModel:(LayoutViewModel *)viewModel;

/**
 *  返回一个UINavigaitonController对象，其rootViewController是LayoutController
 *
 *  @param storyboardName storyboard的名字
 *  @param viewModel      viewModel对象
 *
 *  @return UINavigaitonController对象
 *  @summary 感觉是一个很奇葩的接口，可是很奇怪，如果直接拿出LayoutController对象，手工创建一个UINavigationController作业容器，可是这时如果在UITabBarController的init方法里面，将UINavigationController作为其中一个Tab时，是展示不出内容的！！
 */
+ (UINavigationController *)instantiateNavWithStoryboardName:(NSString *)storyboardName viewModel:(LayoutViewModel *)viewModel;

@end

