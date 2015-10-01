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

@interface ViewController () <UITextViewDelegate>

@property (strong, nonatomic) IBOutlet UITextView *textView;

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
    CGFloat keyboardViewH = 250;
    self.keyboardView = [WMKeyboardView keyboardViewWithKeyboardType:WMKeyboardTypeNumber];
    self.keyboardView.frame = CGRectMake(keyboardViewX, keyboardViewY, keyboardViewW, keyboardViewH);
    self.textView.inputView = self.keyboardView;
    [self.textView.layer setBorderColor:[[UIColor blackColor] CGColor]];
    [self.textView.layer setBorderWidth:1];
    
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
            [self changetext:text InTextView:self.textView];
        }
            break;
            
        case WMKeyButtonTypeDone: {
            [self backgroundTapped];
        }
            break;
            
        case WMKeyButtonTypeOther: {
            [self changetext:text InTextView:self.textView];
        }
            break;
    }
}

/**
 *  修改textView中的文字
 */
- (void)changetext:(NSString *)text InTextView:(UITextView *)textView {
    UITextPosition *beginning = textView.beginningOfDocument;
    UITextPosition *start = textView.selectedTextRange.start;
    UITextPosition *end = textView.selectedTextRange.end;
    NSInteger startIndex = [textView offsetFromPosition:beginning toPosition:start];
    NSInteger endIndex = [textView offsetFromPosition:beginning toPosition:end];
    
    // 将输入框中的文字分成两部分，生成新字符串，判断新字符串是否满足要求
    NSString *originText = textView.text;
    NSString *part1 = [originText substringToIndex:startIndex];
    NSString *part2 = [originText substringFromIndex:endIndex];
    
    NSString *newText = [NSString stringWithFormat:@"%@%@%@", part1, text, part2];
    textView.text = newText;
    
    // 重置光标位置
    UITextPosition *now = [textView positionFromPosition:start offset:text.length];
    UITextRange *range = [textView textRangeFromPosition:now toPosition:now];
    textView.selectedTextRange = range;
}

#pragma mark - UITextViewDelegate

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {
    [self.keyboardView exchangeNumber];
    return YES;
}

@end
