//
//  ViewController.m
//  ConstraintTextField
//
//  Created by 曹世鑫 on 2019/3/5.
//  Copyright © 2019 曹世鑫. All rights reserved.
//

#import "ViewController.h"
#import "CSXConstraintTextField.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self createView];
}
- (void)createView {
    UILabel *label = [[UILabel alloc] init];
    label.frame = CGRectMake(0, 50, 290, 40);
    label.text = @"长度约束，带分割显示";
    label.textColor = [UIColor redColor];
    label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:label];
    
    CSXConstraintTextField *textField = [[CSXConstraintTextField alloc]initWithFrame:CGRectMake(0, 100, 290, 50)];
    textField.backgroundColor = [UIColor redColor];
    textField.keyBoardType = KeyBoardTypeNumber;
    textField.speType = ContentSpeTypeIDCard;
    textField.lengthType = ContentLengthType11;
    [self.view addSubview:textField];
    textField.contentBack = ^(NSString *contentStr) {
        NSLog(@">>>>>>>>>>>>%@",contentStr);
    };
    
    UILabel *lab = [[UILabel alloc] init];
    lab.frame = CGRectMake(0, 190, 290, 40);
    lab.text = @"约束只能显示n位小数";
    lab.textColor = [UIColor redColor];
    lab.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:lab];
    
    UITextField *contentText = [[UITextField alloc]initWithFrame:CGRectMake(0, 240, 290, 50)];
    contentText.placeholder = @"约束只能显示n位小数";
    contentText.keyboardType = UIKeyboardTypeDecimalPad;
    [contentText addTarget:self action:@selector(valueChange:) forControlEvents:UIControlEventEditingChanged];
    [self.view addSubview:contentText];
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
