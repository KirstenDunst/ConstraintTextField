//
//  ConstraintTextField.h
//  ConstraintTextField
//
//  Created by 曹世鑫 on 2019/3/5.
//  Copyright © 2019 曹世鑫. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CSXConstraintTextFieldDelegate <NSObject>

- (void)textField:(UITextField *_Nullable)textfield textContentStr:(NSString *_Nullable)contentStr;

@end

typedef void(^CSXConstraintTextFieldContentBack)(NSString * _Nonnull contentStr);


/** 内容分割方式 */ //标题的分割类型 ，0，默认不分割处理，1身份证类型6444..， 2银行卡类型444..,
typedef NS_ENUM(NSUInteger,ContentSpeType) {
    /** 默认不分割 */
    ContentSpeTypeNull = 0,
    /** 身份证分割方式  6444..*/
    ContentSpeTypeIDCard,
    /** 银行卡分割方式 4444.. */
    ContentSpeTypeBank,
};

NS_ASSUME_NONNULL_BEGIN

@interface CSXConstraintTextField : UIView
//数据带回
@property (nonatomic, copy)CSXConstraintTextFieldContentBack contentBack;
@property (nonatomic, weak)id <CSXConstraintTextFieldDelegate> delegate;

//中间加空格分割类型
@property (nonatomic, assign)ContentSpeType speType;
//长度限制 0默认不限制，限制几位就传多少
@property (nonatomic, assign)int length;
//吊起键盘类型
@property (nonatomic, assign)UIKeyboardType keyBoardType;
@end

NS_ASSUME_NONNULL_END
