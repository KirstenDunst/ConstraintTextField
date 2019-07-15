//
//  ViewController.m
//  ConstraintTextField
//
//  Created by 曹世鑫 on 2019/3/5.
//  Copyright © 2019 曹世鑫. All rights reserved.
//

#import "ViewController.h"
#import "CSXConstraintTextField.h"
#import "CSXAuthCodeTextFieldView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self createView];
}
- (void)createView {
    //1
    UILabel *label = [[UILabel alloc] init];
    label.frame = CGRectMake(0, 50, 290, 40);
    label.text = @"1长度约束，带分割显示";
    label.textColor = [UIColor redColor];
    label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:label];
    
    CSXConstraintTextField *textField = [[CSXConstraintTextField alloc]initWithFrame:CGRectMake(0, 100, 290, 50)];
    textField.backgroundColor = [UIColor redColor];
    textField.keyBoardType = UIKeyboardTypeNumberPad;
    textField.speType = ContentSpeTypeIDCard;
    textField.length = 21;
    [self.view addSubview:textField];
    textField.contentBack = ^(NSString *contentStr) {
        NSLog(@">>>>>>>>>>>>%@",contentStr);
    };
    
    //2
    UILabel *lab = [[UILabel alloc] init];
    lab.frame = CGRectMake(0, 190, 290, 40);
    lab.text = @"2约束只能显示n位小数";
    lab.textColor = [UIColor redColor];
    lab.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:lab];
    
    UITextField *contentText = [[UITextField alloc]initWithFrame:CGRectMake(0, 240, 290, 50)];
    contentText.placeholder = @"约束只能显示n位小数";
    contentText.keyboardType = UIKeyboardTypeDecimalPad;
    [contentText addTarget:self action:@selector(valueChange:) forControlEvents:UIControlEventEditingChanged];
    [self.view addSubview:contentText];
    
    //3
    UILabel *lab3 = [[UILabel alloc] init];
    lab3.frame = CGRectMake(0, 300, 290, 40);
    lab3.text = @"3显示验证码倒计时按钮和输入框组件";
    lab3.textColor = [UIColor redColor];
    lab3.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:lab3];
    CSXAuthCodeTextFieldView *accountView = [[CSXAuthCodeTextFieldView alloc]initWithFrame:CGRectMake(0, 350, self.view.frame.size.width, 50)];
    [accountView hintWithTitle:@"手机号" PalceHoderStr:@"请输入申请人手机号" keyBoard:UIKeyboardTypeNumberPad isNeedVertificdCode:NO isNeedSpeView:YES isCanEdit:YES];
    [self.view addSubview:accountView];
    CSXAuthCodeTextFieldView *passwordView = [[CSXAuthCodeTextFieldView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(accountView.frame), self.view.frame.size.width, 50)];
    [passwordView hintWithTitle:@"验证码" PalceHoderStr:@"请输入验证码" keyBoard:UIKeyboardTypeNumberPad isNeedVertificdCode:YES isNeedSpeView:YES isCanEdit:YES];
    __weak typeof(passwordView)weakPassView = passwordView;
    passwordView.vertificdChoose = ^{
        [weakPassView VertificdCodeTime];
    };
    [self.view addSubview:passwordView];
}
- (void)valueChange:(UITextField *)textfield {
    [self limitTxField:textfield length:4];
}
- (void)limitTxField:(UITextField *)textField length:(NSInteger)length{
    if (textField && textField.text.length > 0) {
        if ([self isNumberOrDrietWithStr:textField.text]) {
            NSArray *array = [textField.text componentsSeparatedByString:@"."];
            if (array.count>1 && [array.lastObject length]>length) {
                textField.text = [NSString stringWithFormat:@"%@.%@",array.firstObject,[array.lastObject substringToIndex:length]];
            }else {
                if (array.count == 3 && [self isNullOrNilWithObject:array.lastObject]) {
                    if ([self isNullOrNilWithObject:array[1]]) {
                        textField.text = [NSString stringWithFormat:@"%@.",array.firstObject];
                    }else {
                        textField.text = [NSString stringWithFormat:@"%@.%@",array.firstObject,array[1]];
                    }
                }else if ([self isNullOrNilWithObject:array.firstObject] && [self isNullOrNilWithObject:array.lastObject]) {
                    textField.text = @"0.";
                }
            }
        }else {
            textField.text = @"";
        }
    }
}
- (BOOL)isNumberOrDrietWithStr:(NSString *)str {
    NSString *phoneRegex = @"^[0-9(.)]{0,}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:str];
}
- (BOOL)isNullOrNilWithObject:(id)object {
    if (object == nil || [object isEqual:[NSNull null]]) {
        return YES;
    } else if ([object isKindOfClass:[NSString class]]) {
        NSString *str = [object stringByReplacingOccurrencesOfString:@" " withString:@""];
        if ([str isEqualToString:@""]) {
            return YES;
        } else {
            return NO;
        }
    } else if ([object isKindOfClass:[NSNumber class]]) {
        if ([object isEqualToNumber:@0]) {
            return NO;
        } else {
            return NO;
        }
    }
    return NO;
}
@end
