//
//  CSXAuthCodeTextFieldView.m
//  ConstraintTextField
//
//  Created by 曹世鑫 on 2019/3/5.
//  Copyright © 2019 曹世鑫. All rights reserved.
//

#import "CSXAuthCodeTextFieldView.h"
#import "CSXGCDTimerManager.h"

@interface CSXAuthCodeTextFieldView ()<UITextFieldDelegate>
@property (nonatomic, strong)UILabel *titleLabel;
@property (nonatomic, strong)UIButton *verifyBtn;
@property (nonatomic, strong)UIView *speView;
@end

@implementation CSXAuthCodeTextFieldView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self createView];
    }
    return self;
}
- (void)createView {
    [self addSubview:self.titleLabel];
    [self addSubview:self.contentTextField];
}

- (void)setContentStr:(NSString *)contenStr {
    self.contentTextField.text = contenStr;
}

- (void)hintWithTitle:(NSString *)titleStr PalceHoderStr:(NSString *)placeStr keyBoard:(UIKeyboardType)keyBoardType isNeedVertificdCode:(BOOL)need isNeedSpeView:(BOOL)isNeedSpe  isCanEdit:(BOOL)isCanEdit {
    self.titleLabel.text = titleStr;
    self.contentTextField.placeholder = placeStr;
    self.contentTextField.keyboardType = keyBoardType;
    if (need) {
        [self addSubview:self.verifyBtn];
        self.contentTextField.frame = CGRectMake(self.contentTextField.frame.origin.x, 0, CGRectGetMinX(self.verifyBtn.frame)-self.contentTextField.frame.origin.x-10, self.frame.size.height);
    }
    if (isNeedSpe) {
        [self addSubview:self.speView];
    }
    self.contentTextField.enabled = isCanEdit;
}

- (void)verifyBtnChoose:(UIButton *)sender {
    if (self.vertificdChoose) {
        self.vertificdChoose();
    }
}

- (void)valueChange:(UITextField *)sender {
    if (self.contentChange) {
        self.contentChange(sender.text);
    }
}

- (void)VertificdCodeTime {
    NSLog(@"发送成功");
    [self beginTimerForReSendWithBtn:self.verifyBtn];
}

#pragma mark ---------UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}
#pragma mark ---------------lazy
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 80, self.frame.size.height)];
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.font = [UIFont systemFontOfSize:15];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _titleLabel;
}
- (UITextField *)contentTextField {
    if (!_contentTextField) {
        _contentTextField = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.titleLabel.frame)+15, 0, [UIScreen mainScreen].bounds.size.width-CGRectGetMaxX(self.titleLabel.frame)-30, self.frame.size.height)];
        _contentTextField.placeholder = @"";
        [_contentTextField addTarget:self action:@selector(valueChange:) forControlEvents:UIControlEventEditingChanged];
        _contentTextField.textColor = [UIColor blackColor];
        _contentTextField.font = [UIFont systemFontOfSize:15];
        _contentTextField.delegate = self;
        _contentTextField.returnKeyType = UIReturnKeyDone;
    }
    return _contentTextField;
}

- (UIButton *)verifyBtn {
    if (!_verifyBtn) {
        _verifyBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        _verifyBtn.frame = CGRectMake([UIScreen mainScreen].bounds.size.width-15-90, self.frame.size.height/2-25/2, 90, 25);
        [_verifyBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        [_verifyBtn setTintColor:[UIColor orangeColor]];
        [_verifyBtn addTarget:self action:@selector(verifyBtnChoose:) forControlEvents:UIControlEventTouchUpInside];
        [_verifyBtn setBackgroundColor:[UIColor whiteColor]];
        _verifyBtn.layer.cornerRadius = _verifyBtn.frame.size.height/2;
        _verifyBtn.clipsToBounds = YES;
        _verifyBtn.titleLabel.font = [UIFont systemFontOfSize:12];;
        _verifyBtn.layer.borderWidth = 1;
        _verifyBtn.layer.borderColor = [UIColor orangeColor].CGColor;
    }
    return _verifyBtn;
}
- (UIView *)speView {
    if (!_speView) {
        _speView = [[UIView alloc]initWithFrame:CGRectMake(15, self.frame.size.height-0.25, [UIScreen mainScreen].bounds.size.width-15, 0.25)];
        _speView.backgroundColor = [UIColor lightGrayColor];
    }
    return _speView;
}

- (void)beginTimerForReSendWithBtn:(UIButton *)sender{
    sender.userInteractionEnabled = NO;
    //倒计时时间
    __block NSInteger timeOut = 60;
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    [[CSXGCDTimerManager sharedInstance]scheduledDispatchTimerWithName:@"newBusinessVertify" timeInterval:1.0 queue:queue repeats:timeOut actionOption:AbandonPreviousAction action:^{
        //倒计时结束，关闭
        if (timeOut <= 0) {
            dispatch_async(dispatch_get_main_queue(), ^{
                sender.userInteractionEnabled = YES;
                sender.titleLabel.text = @"获取验证码";
                [sender setTitle:@"获取验证码" forState:UIControlStateNormal];
                sender.layer.borderColor = [UIColor orangeColor].CGColor;
                [sender setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
            });
        } else {
            int allTime = 61;
            int seconds = timeOut % allTime;
            dispatch_async(dispatch_get_main_queue(), ^{
                NSString *titleStr = [NSString stringWithFormat:@"%ds后重发",seconds];
                sender.titleLabel.text = titleStr;
                [sender setTitle:titleStr forState:UIControlStateNormal];
                sender.layer.borderColor = [UIColor lightGrayColor].CGColor;
                [sender setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
            });
            timeOut--;
        }
    }];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
