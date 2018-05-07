//
//  ZMLoginView.m
//  ZMBCY
//
//  Created by ZOMAKE on 2018/1/5.
//  Copyright © 2018年 Brance. All rights reserved.
//

#import "ZMLoginView.h"
#import "ZMRegisterViewController.h"
#import "BaseNavigationController.h"

@interface ZMLoginView()

@property (nonatomic, strong) UIView        *mainView;
@property (nonatomic, strong) UIScrollView  *scrollView;
@property (nonatomic, strong) UIImageView   *bgImageView;
@property (nonatomic, strong) UIButton      *closeButton;

@property (nonatomic, strong) UIImageView   *logoImageView;
@property (nonatomic, strong) UITextField   *userNameField;
@property (nonatomic, strong) UITextField   *passwordField;
@property (nonatomic, strong) YYLabel       *forgetPwdLabel;
@property (nonatomic, strong) YYLabel       *registerLabel;
@property (nonatomic, strong) UIButton      *loginButton;
@property (nonatomic, strong) YYLabel       *closeLabel;

@property (nonatomic, strong) UILabel       *bottomLine1;
@property (nonatomic, strong) UILabel       *bottomLine2;

@end

@implementation ZMLoginView

- (UIView *)mainView{
    if (!_mainView) {
        _mainView = [UIView new];
        _mainView.backgroundColor = [ZMColor clearColor];
        [self.scrollView addSubview:_mainView];
        [_mainView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.mas_equalTo(0);
            make.width.mas_equalTo(self.width);
            make.height.mas_equalTo(self.height + 50);
        }];
    }
    return _mainView;
}

- (UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
        [self addSubview:_scrollView];
        [self insertSubview:_scrollView aboveSubview:self.bgImageView];
        [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.mas_equalTo(0);
            make.width.mas_equalTo(self.width);
            make.height.mas_equalTo(self.height);
        }];
        [_scrollView.superview layoutIfNeeded];
        _scrollView.contentSize = CGSizeMake(0, _scrollView.height + 1);
    }
    return _scrollView;
}

- (UIImageView *)bgImageView{
    if (!_bgImageView) {
        _bgImageView = [UIImageView new];
        _bgImageView.image = [UIImage imageNamed:@"login_bg_640X1136"];
        [self addSubview:_bgImageView];
        [self sendSubviewToBack:_bgImageView];
        [_bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.bottom.mas_equalTo(0);
        }];
    }
    return _bgImageView;
}

- (UIButton *)closeButton{
    if (!_closeButton) {
        _closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        UIImage *image = [UIImage imageNamed:@"login_alert_cancel"];
        _closeButton.layer.cornerRadius = 30 * 0.5;
        _closeButton.layer.masksToBounds = YES;
        _closeButton.layer.borderColor = [ZMColor whiteColor].CGColor;
        _closeButton.layer.borderWidth = 1;
        [_closeButton setImage:image forState:UIControlStateNormal];
        [self addSubview:_closeButton];
        [self bringSubviewToFront:_closeButton];
        [_closeButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(20 + 5);
            make.left.mas_equalTo(5);
            make.width.mas_equalTo(30);
            make.height.mas_equalTo(30);
        }];
        [_closeButton.superview layoutIfNeeded];
        [_closeButton addTarget:self action:@selector(clickLoginOut:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _closeButton;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [ZMColor appGraySpaceColor];
    }
    return self;
}

- (void)setupUI{
    [self closeButton];
    [self bgImageView];
    [self mainView];
    WEAKSELF;
    self.logoImageView = [UIImageView new];
    UIImage *logoImage = [UIImage imageNamed:@"login_header"];
    self.logoImageView.image = logoImage;
    [self.mainView addSubview:self.logoImageView];
    [self.logoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(logoImage.size);
        make.centerX.mas_equalTo(self.mainView);
        make.top.mas_equalTo(CGRectGetMaxY(self.closeButton.frame) + 40);
    }];
    
    self.userNameField = [[UITextField alloc] init];
    self.userNameField.font = [UIFont systemFontOfSize:15];
    NSAttributedString *userNameString = [[NSAttributedString alloc] initWithString:@"用户名" attributes:@{NSForegroundColorAttributeName:[ZMColor appLightGrayColor],
                    NSFontAttributeName:            self.userNameField.font
                                        }];
    self.userNameField.attributedPlaceholder = userNameString;
    self.userNameField.textColor = [ZMColor whiteColor];
    self.userNameField.clearButtonMode=UITextFieldViewModeWhileEditing;
    [self.mainView addSubview:self.userNameField];
    [self.userNameField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.right.mas_equalTo(-20);
        make.height.mas_equalTo(50);
        make.top.mas_equalTo(self.logoImageView.mas_bottom).with.offset(60);
    }];
    UIView *userNameMainView = [UIView new];
    
    UIImageView *userNameView = [UIImageView new];
    UIImage *userNameLeftImage = [UIImage imageNamed:@"icon_telephone"];
    userNameView.image = userNameLeftImage;
    userNameView.size = userNameLeftImage.size;
    userNameView.x = 0;
    userNameView.y = 0;
    userNameMainView.size = CGSizeMake(userNameLeftImage.size.width + 10, userNameLeftImage.size.height);
    [userNameMainView addSubview:userNameView];
    
    self.userNameField.leftView = userNameMainView;
    self.userNameField.leftViewMode = UITextFieldViewModeAlways;
    
    self.bottomLine1 = [UILabel new];
    self.bottomLine1.backgroundColor = [ZMColor appLightGrayColor];
    [self.mainView addSubview:self.bottomLine1];
    [self.bottomLine1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(KMarginLeft);
        make.right.mas_equalTo(-KMarginLeft);
        make.height.mas_equalTo(0.5);
        make.top.mas_equalTo(self.userNameField.mas_bottom).with.offset(1);
    }];
    
    self.passwordField = [[UITextField alloc] init];
    self.passwordField.font = [UIFont systemFontOfSize:15];
    self.passwordField.textColor = [ZMColor whiteColor];
    NSAttributedString *passwordString = [[NSAttributedString alloc] initWithString:@"密码" attributes:@{NSForegroundColorAttributeName:[ZMColor appLightGrayColor],
                    NSFontAttributeName:self.userNameField.font}];
    self.passwordField.attributedPlaceholder = passwordString;
    self.passwordField.clearButtonMode=UITextFieldViewModeWhileEditing;
    [self.mainView addSubview:self.passwordField];
    [self.passwordField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.right.mas_equalTo(-20);
        make.height.mas_equalTo(50);
        make.top.mas_equalTo(self.userNameField.mas_bottom).with.offset(1);
    }];
    UIView *passwordMainView = [UIView new];
    
    UIImageView *passwordView = [UIImageView new];
    UIImage *passwordLeftImage = [UIImage imageNamed:@"icon_lock"];
    passwordView.image = passwordLeftImage;
    passwordView.size = passwordLeftImage.size;
    passwordView.x = 0;
    passwordView.y = 0;
    passwordMainView.size = CGSizeMake(passwordLeftImage.size.width + 10, passwordLeftImage.size.height);
    [passwordMainView addSubview:passwordView];
    
    self.passwordField.leftView = passwordMainView;
    self.passwordField.leftViewMode = UITextFieldViewModeAlways;
    
    self.bottomLine2 = [UILabel new];
    self.bottomLine2.backgroundColor = [ZMColor appLightGrayColor];
    [self.mainView addSubview:self.bottomLine2];
    [self.bottomLine2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(KMarginLeft);
        make.right.mas_equalTo(-KMarginLeft);
        make.height.mas_equalTo(0.5);
        make.top.mas_equalTo(self.passwordField.mas_bottom).with.offset(1);
    }];

    //忘记密码
    self.forgetPwdLabel = [YYLabel new];
    self.forgetPwdLabel.font = [UIFont systemFontOfSize:13];
    self.forgetPwdLabel.text = @"忘记密码？";
    self.forgetPwdLabel.textColor = [ZMColor whiteColor];
    [self.mainView addSubview:self.forgetPwdLabel];
    [self.forgetPwdLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.userNameField.mas_left);
        make.top.mas_equalTo(self.passwordField.mas_bottom).with.offset(20);
    }];
    self.forgetPwdLabel.textTapAction = ^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
        NSLog(@"点击了忘记密码");
    };
    
    //注册
    self.registerLabel = [YYLabel new];
    self.registerLabel.font = [UIFont systemFontOfSize:13];
    self.registerLabel.textColor = [ZMColor whiteColor];
    self.registerLabel.text = @"去注册";
    [self.mainView addSubview:self.registerLabel];
    [self.registerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.userNameField.mas_right);
        make.top.mas_equalTo(self.passwordField.mas_bottom).with.offset(20);
    }];
    self.registerLabel.textTapAction = ^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
        NSLog(@"点击了注册");
        //如果在弹出模态框之前没有包装导航控制器，这里是不会push成功的
        ZMRegisterViewController *vc = [[ZMRegisterViewController alloc] init];
        [weakSelf.viewController.navigationController pushViewController:vc animated:YES];
    };
    
    //登录
    self.loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.loginButton.titleLabel.font = [UIFont systemFontOfSize:15];
    self.loginButton.layer.masksToBounds = YES;
    self.loginButton.layer.cornerRadius = 20;
    self.loginButton.backgroundColor = [ZMColor colorWithHexString:@"#55667D"];
    [self.loginButton setTitle:@"登录" forState:UIControlStateNormal];
    [self.mainView addSubview:self.loginButton];
    [self.loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(KMarginLeft);
        make.right.mas_equalTo(-KMarginLeft);
        make.top.mas_equalTo(self.forgetPwdLabel.mas_bottom).with.offset(25);
        make.height.mas_equalTo(45);
    }];
    [self.loginButton addTarget:self action:@selector(clickLoginButton:) forControlEvents:UIControlEventTouchUpInside];
    
    //继续浏览
    self.closeLabel = [YYLabel new];
    self.closeLabel.font = [UIFont systemFontOfSize:13];
    self.closeLabel.textColor = [ZMColor whiteColor];
    self.closeLabel.textAlignment = NSTextAlignmentCenter;
    self.closeLabel.text = @"继续浏览";
    [self.mainView addSubview:self.closeLabel];
    [self.closeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.mainView);
        make.top.mas_equalTo(self.loginButton.mas_bottom).with.offset(25);
    }];
    self.closeLabel.textTapAction = ^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
        [weakSelf.viewController dismissViewControllerAnimated:YES completion:^{
        }];
    };
}

#pragma mark - 登录
- (void)clickLoginButton:(UIButton *)btn{
    
    if (![self.userNameField.text stringByTrim].length) {
        [MBProgressHUD showPromptMessage:@"请输入用户名"];
        return;
    }
    if (![self.passwordField.text stringByTrim].length) {
        [MBProgressHUD showPromptMessage:@"请输入密码"];
        return;
    }
    NSLog(@"去登录");
    NSString *username = self.userNameField.text;
    NSString *password = self.passwordField.text;
    WEAKSELF;
    [MBProgressHUD showMessage:@"正在登录..." toView:self];
    if (username.length && password.length) {
        [AVUser logInWithUsernameInBackground:username password:password block:^(AVUser *user, NSError *error) {
            [MBProgressHUD hideAllHUDsForView:weakSelf animated:YES];
            if (error) {
                NSDictionary *dic = error.userInfo;
                NSLog(@"登录失败 %@", dic[@"error"]);
                [MBProgressHUD showPromptMessage:@"用户名和密码不匹配"];
            } else {
                [MBProgressHUD showPromptMessage:@"登录成功"];
                //这里存储 sessionToken，下次直接用sessionToken 登录
                [[ZMUserInfo shareUserInfo] loadUserInfo:user];
                [[ZMUserInfo shareUserInfo] saveUserInfoToSandbox];
                
                //发送登录成功通知
                [[NSNotificationCenter defaultCenter] postNotificationName:KLoginStateChangeNotice object:nil];
                
                [weakSelf.viewController dismissViewControllerAnimated:YES completion:^{
                }];
                
//                //尝试解析图片,这是自定义属性
//                NSData *imageStr = [user objectForKey:@"thumb"];
//                // 将NSData转为UIImage
//                UIImage *decodedImage = [UIImage imageWithData: imageStr];
//                if (decodedImage) {
//                    [ZMUserInfo shareUserInfo].headImage = decodedImage;
//                }
//                NSLog(@"%@",decodedImage);
            }
        }];
    }
}

#pragma mark - 退出页面
- (void)clickLoginOut:(UIButton *)btn{
    btn.enabled = NO;
    [self.viewController dismissViewControllerAnimated:YES completion:^{
        
    }];
}

@end
