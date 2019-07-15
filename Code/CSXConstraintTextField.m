//
//  ConstraintTextField.m
//  ConstraintTextField
//
//  Created by 曹世鑫 on 2019/3/5.
//  Copyright © 2019 曹世鑫. All rights reserved.
//

#import "CSXConstraintTextField.h"

@interface CSXConstraintTextField ()<UITextFieldDelegate>
@property (nonatomic, strong)UITextField *textField;
@end

@implementation CSXConstraintTextField

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.length = 0;
        [self createViewWithFrame:frame];
    }
    return self;
}
- (void)createViewWithFrame:(CGRect)frame {
    self.textField.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
    [self addSubview:self.textField];
}

- (void)setKeyBoardType:(UIKeyboardType)keyBoardType {
    self.textField.keyboardType = keyBoardType;
}

// 文本框编辑监听
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (self.speType != ContentSpeTypeNull) {
        int countNumber = 4;
        if (self.speType == ContentSpeTypeIDCard) {
            countNumber = 6;
            if ([textField.text length] > 6) {
                countNumber = 4;
            }
        }
        // 每间隔4个字符插入一个空格并在删除时去掉
        NSMutableString *strmText = [NSMutableString stringWithString:textField.text];
        if (self.speType == ContentSpeTypeIDCard) {
            if ([textField.text length] == range.location) {
                // 插入
                if (([textField.text length]-(countNumber == 4?7:0))%(countNumber+1) == countNumber) {
                    [strmText appendString:@" "];
                }
            } else {
                // 删除
                if ([textField.text length]) {
                    if ([textField.text length] >=7 && ([textField.text length] -7)%5 == 0) {
                        strmText = [NSMutableString stringWithString:[strmText substringToIndex:strmText.length - 1]];
                    }
                }
            }
        }else {
            if ([textField.text length] == range.location) {
                // 插入
                if ([textField.text length]%5 == 4) {
                    [strmText appendString:@" "];
                }
            } else {
                // 删除
                if ([textField.text length] && [textField.text length]%5 == 0) {
                    strmText = [NSMutableString stringWithString:[strmText substringToIndex:strmText.length - 1]];
                }
            }
        }
        textField.text = strmText;
    }
    
    NSString *strLimitStr = [textField.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    if (strLimitStr.length >= self.length && self.length != 0) {
        strLimitStr = [strLimitStr substringToIndex:self.length];
        textField.text = [self dealType:self.speType WithString:strLimitStr];
        if ([[textField.text substringFromIndex:textField.text.length-1] isEqualToString:@" "]) {
            textField.text = [textField.text substringToIndex:textField.text.length-1];
        }
        if (string.length>0) {
            return NO;
        }else {
            return YES;
        }
    }
    return YES;
}
//银行卡号，每四位多加一个空格
- (NSString *)dealType:(NSInteger)speType WithString:(NSString *)number {
    NSString *doneTitle = @"";
    if (speType == 0) {
        return number;
    }
    int count = 0;
    for (int i = 0; i < number.length; i++) {
        int numberCount;
        if (speType == 1) {
            numberCount = i <= 6?6:4;
        }else {
            numberCount = 4;
        }
        count++;
        doneTitle = [doneTitle stringByAppendingString:[number substringWithRange:NSMakeRange(i, 1)]];
        if (count == numberCount) {
            doneTitle = [NSString stringWithFormat:@"%@ ", doneTitle];
            count = 0;
        }
    }
    return doneTitle;
}
- (void)valueChange:(UITextField *)textFie {
    if (self.delegate && [self.delegate respondsToSelector:@selector(textField:textContentStr:)]) {
        [self.delegate textField:textFie textContentStr:[textFie.text stringByReplacingOccurrencesOfString:@" " withString:@""]];
    }
    if (self.contentBack) {
        self.contentBack([textFie.text stringByReplacingOccurrencesOfString:@" " withString:@""]);
    }
}

#pragma mark ------lazy
- (UITextField *)textField {
    if (!_textField) {
        _textField = [[UITextField alloc]init];
        _textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        [_textField addTarget:self action:@selector(valueChange:) forControlEvents:UIControlEventEditingChanged];
        _textField.delegate = self;
    }
    return _textField;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
