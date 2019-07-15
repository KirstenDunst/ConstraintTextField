//
//  CSXAuthCodeTextFieldView.h
//  ConstraintTextField
//
//  Created by 曹世鑫 on 2019/3/5.
//  Copyright © 2019 曹世鑫. All rights reserved.
//

#import <UIKit/UIKit.h>

//验证码触发
typedef void(^VertificdBtnChoose)(void);
//输入框触发事件
typedef void(^ContentTextChange)(NSString * _Nullable ContentStr);

NS_ASSUME_NONNULL_BEGIN

@interface CSXAuthCodeTextFieldView : UIView

//没有倒计时，不用触发这个block方法
@property (nonatomic, copy)VertificdBtnChoose vertificdChoose;
@property (nonatomic, copy)ContentTextChange contentChange;
//内部的输入框，共外部调用操作
@property (nonatomic, strong)UITextField *contentTextField;
/**
 实例化账号，验证码view
 
 @param titleStr 提示标题
 @param placeStr 输入框的placehodr
 @param keyBoardType 键盘类型
 @param need 是否需要添加验证码组件
 @param isNeedSpe 是否需要分割线
 */
- (void)hintWithTitle:(NSString *)titleStr PalceHoderStr:(NSString *)placeStr keyBoard:(UIKeyboardType)keyBoardType isNeedVertificdCode:(BOOL)need isNeedSpeView:(BOOL)isNeedSpe isCanEdit:(BOOL)isCanEdit;

/**
 设置输入框的内容
 
 @param contenStr 输入框要显示内容
 */
- (void)setContentStr:(NSString *)contenStr;

//点击开始倒计时请求触发请求后台发送验证码之后调这个方法来锁定按钮，并进入倒计时。
- (void)VertificdCodeTime;


@end

NS_ASSUME_NONNULL_END
