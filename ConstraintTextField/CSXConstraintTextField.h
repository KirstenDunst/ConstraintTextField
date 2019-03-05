//
//  ConstraintTextField.h
//  ConstraintTextField
//
//  Created by 曹世鑫 on 2019/3/5.
//  Copyright © 2019 曹世鑫. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CSXConstraintTextFieldDelegate <NSObject>

- (void)textField:(UITextField *)textfield textContentStr:(NSString *)contentStr;

@end

typedef void(^CSXConstraintTextFieldContentBack)(NSString *contentStr);


/** 内容分割方式 */ //标题的分割类型 ，0，默认不分割处理，1身份证类型6444..， 2银行卡类型444..,
typedef NS_ENUM(NSUInteger,ContentSpeType) {
    /** 默认不分割 */
    ContentSpeTypeNull = 0,
    /** 身份证分割方式  6444..*/
    ContentSpeTypeIDCard,
    /** 银行卡分割方式 4444.. */
    ContentSpeTypeBank,
};

/** 内容长度限制要求 */ //0默认不限制，1限制18位，2限制11位
typedef NS_ENUM(NSUInteger,ContentLengthType) {
    /** 默认不限制 */
    ContentLengthTypeNull = 0,
    /** 限制长度18位*/
    ContentLengthType18,
    /** 限制长度11位*/
    ContentLengthType11,
    /** 限制长度12位*/
    ContentLengthType12,
};

/** 键盘调用的特殊使用 */ //默认键盘0，全数字键盘1，营业执照身份证类型2
typedef NS_ENUM(NSUInteger,KeyBoardType) {
    /** 默认不特殊选择键盘 */
    KeyBoardTypeNull = 0,
    /** 全数字键盘*/
    KeyBoardTypeNumber,
    /** 身份证，营业执照类型*/
    KeyBoardTypeIDLicense,
};

NS_ASSUME_NONNULL_BEGIN

@interface CSXConstraintTextField : UIView
//数据带回
@property (nonatomic, copy)CSXConstraintTextFieldContentBack contentBack;
@property (nonatomic, weak)id <CSXConstraintTextFieldDelegate> delegate;

//中间加空格分割类型
@property (nonatomic, assign)ContentSpeType speType;
//长度限制多少位类型
@property (nonatomic, assign)ContentLengthType lengthType;
//吊起键盘类型
@property (nonatomic, assign)KeyBoardType keyBoardType;
@end

NS_ASSUME_NONNULL_END
