//
//  ViewController.m
//  SelfDefineKeyboard
//
//  Created by wamaker on 15/9/10.
//  Copyright (c) 2015年 wamaker. All rights reserved.
//

#import "ViewController.h"

#import "WMKeyboardView.h"

#import "WMKeyKeyboardDefine.h"

@interface ViewController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *textField;

@property (strong, nonatomic) WMKeyboardView *keyboardView;

@end

@implementation ViewController

#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backgroundTapped)];
    [self.view addGestureRecognizer:recognizer];
    
    CGFloat keyboardViewX = 0;
    CGFloat keyboardViewY = 0;
    CGFloat keyboardViewW = CGRectGetWidth(self.view.frame);
    CGFloat keyboardViewH = WMKeyboardViewHeight;
    self.keyboardView = [WMKeyboardView keyboardViewWithKeyboardType:WMKeyboardTypeNumber];
    self.keyboardView.frame = CGRectMake(keyboardViewX, keyboardViewY, keyboardViewW, keyboardViewH);
    self.textField.inputView = self.keyboardView;
    
    WS(weakSelf);
    [self.keyboardView setWMKeyboardBlock:^(WMKeyButtonType type, NSString *text) {
        [weakSelf changeTextField:type Text:text];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Private

- (void)backgroundTapped {
    [self.view endEditing:YES];
}

- (void)changeTextField:(WMKeyButtonType)type Text:(NSString *)text {
    switch (type) {
        case WMKeyButtonTypeDel: {
            [self changetext:text InTextField:self.textField];
        }
            break;
            
        case WMKeyButtonTypeDone: {
            [self backgroundTapped];
        }
            break;
            
        case WMKeyButtonTypeOther: {
            [self changetext:text InTextField:self.textField];
        }
            break;
    }
}

/**
 *  修改textView中的文字
 */
- (void)changetext:(NSString *)text InTextField:(UITextField *)textField {
    UITextPosition *beginning = textField.beginningOfDocument;
    UITextPosition *start = textField.selectedTextRange.start;
    UITextPosition *end = textField.selectedTextRange.end;
    NSInteger startIndex = [textField offsetFromPosition:beginning toPosition:start];
    NSInteger endIndex = [textField offsetFromPosition:beginning toPosition:end];
    
    // 将输入框中的文字分成两部分，生成新字符串，判断新字符串是否满足要求
    NSString *originText = textField.text;
    NSString *part1 = [originText substringToIndex:startIndex];
    NSString *part2 = [originText substringFromIndex:endIndex];
    
    NSInteger offset;
    
    if (![text isEqualToString:@""]) {
        offset = text.length;
    } else {
        if (startIndex == endIndex) { // 只删除一个字符
            if (startIndex == 0) {
                return;
            }
            offset = -1;
            part1 = [part1 substringToIndex:(part1.length - 1)];
        } else {
            offset = 0;
        }
    }
    
    NSString *newText = [NSString stringWithFormat:@"%@%@%@", part1, text, part2];
    textField.text = newText;
    
    // 重置光标位置
    UITextPosition *now = [textField positionFromPosition:start offset:offset];
    UITextRange *range = [textField textRangeFromPosition:now toPosition:now];
    textField.selectedTextRange = range;
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    [self.keyboardView exchangeNumber];
    return YES;
}

@end
