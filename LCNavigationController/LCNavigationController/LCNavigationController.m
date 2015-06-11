//
//  LCNavigationController.m
//  LCNavigationController
//  自定义的navigationController
//  Created by Ceres on 15/5/1.
//  Copyright (c) 2015年 www.duoc.cn. All rights reserved.
//

#import "LCNavigationController.h"

@interface LCNavigationController ()

@end

@implementation LCNavigationController




- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


//设置title
- (void)navigationItemInit:(UIViewController*)viewController
{
    UILabel* titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,40,175,44)];
    titleLabel.backgroundColor = [UIColor clearColor];  //设置Label背景透明
    titleLabel.font            = [UIFont boldSystemFontOfSize:16];  //设置文本字体与大小
    titleLabel.textColor       = [UIColor whiteColor];  //设置文本颜色
    titleLabel.textAlignment   = NSTextAlignmentLeft;
    viewController.navigationItem.titleView = titleLabel;
}


//left
- (UIBarButtonItem *)navBarItemWithTarget:(id)target
                                   action:(SEL)action
                                imageName:(NSString*)imgName
{
    UIButton *leftbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftbutton.frame = CGRectMake(10, 4, 42, 40);
    [leftbutton setBackgroundImage:[UIImage imageNamed:imgName] forState:UIControlStateNormal];
    [leftbutton addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *letfBarItem = [[UIBarButtonItem alloc] initWithCustomView:leftbutton];
    return letfBarItem;
}


#pragma mark - presentViewController && pushViewController method
- (void)presentViewController:(UIViewController *)viewControllerToPresent animated:(BOOL)flag
                   completion:(void (^)(void))completion
{
    [super presentViewController:viewControllerToPresent animated:flag completion:completion];
    // 添加返回
    UINavigationController *nav = (UINavigationController*)viewControllerToPresent;
    if ([self.viewControllers count] > 1){
        if (nav.topViewController.navigationItem.leftBarButtonItem == nil){
            nav.topViewController.navigationItem.leftBarButtonItem =
            [self navBarItemWithTarget:self
                                action:@selector(dismissLeftBtnPress:)
                             imageName:@"icon_return.png"];
        }
        if (nav.topViewController.navigationItem.rightBarButtonItem == nil)
        {
            nav.topViewController.navigationItem.rightBarButtonItem = [self navBarItemWithTarget:self action:@selector(rightBtnPressed:) imageName:@"icon_personal.png"];
        }
        
        [self navigationItemInit:nav.topViewController];
    }
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    [super pushViewController:viewController animated:animated];
    
    // 添加返回
    if ([self.viewControllers count] > 1){
        if (viewController.navigationItem.leftBarButtonItem == nil){
            viewController.navigationItem.leftBarButtonItem =
            [self navBarItemWithTarget:self
                                action:@selector(backBtnPressed:)
                             imageName:@"icon_return.png"];
        }
        if (viewController.navigationItem.rightBarButtonItem == nil)
        {
            viewController.navigationItem.rightBarButtonItem =
            [self navBarItemWithTarget:self
                                action:@selector(rightBtnPressed:)
                             imageName:@"icon_personal.png"];
        }
        
        [self navigationItemInit:viewController];
    }
}

//right
- (void)rightBtnPressed:(id)sender
{
    
}

- (void)backBtnPressed:(id)sender
{
    [super popViewControllerAnimated:YES];
}

- (void)dismissLeftBtnPress:(id)sender
{
    [super dismissViewControllerAnimated:YES completion:nil];
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

@end
