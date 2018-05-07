//
//  ZMHomeView.h
//  ZMBCY
//
//  Created by ZOMAKE on 2018/1/5.
//  Copyright © 2018年 Brance. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZMNavView.h"

@interface ZMHomeView : UIView

@property (nonatomic, strong) ZMNavView    *nav;

@property (nonatomic, strong) UIImageView       *topImageView;
@property (nonatomic, strong) UILabel           *tipLabel;
@property (nonatomic, strong) UIButton          *loginButton;
@property (nonatomic, strong) UIButton          *registerButton;

- (void)showUI:(BOOL)isLogin;

@end
