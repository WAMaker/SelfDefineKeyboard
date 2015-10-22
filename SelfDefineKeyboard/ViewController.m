//
//  ViewController.m
//  SelfDefineKeyboard
//
//  Created by wamaker on 15/9/10.
//  Copyright (c) 2015年 wamaker. All rights reserved.
//

#import "ViewController.h"

#import "WMKeyboardIAView.h"
#import "WMKeyboardNumberView.h"
#import "WMKeyboardSpecialView.h"

#import "WMKeyboardDefine.h"
#import "UITextView+extension.h"
#import "UITextField+extension.h"

@interface ViewController () <UITextFieldDelegate,
                                WMKeyboardIAViewDelegate>

@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UITextView *textView;

@property (strong, nonatomic) WMKeyboardIAView *keyboardIAView;
@property (strong, nonatomic) WMKeyboardSpecialView *otherKeyboardView;
@property (strong, nonatomic) WMKeyboardNumberView *numberKeyboardView;

@property (assign, nonatomic) WMKeyboardOtherType currentType;

@end

@implementation ViewController

#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backgroundTapped)];
    [self.view addGestureRecognizer:recognizer];
    
    [self handleView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Private

- (void)handleView {
    CGFloat viewW = CGRectGetWidth(self.view.frame);
    
    CGFloat keyboardViewX = 0;
    CGFloat keyboardViewY = 0;
    CGFloat keyboardViewW = viewW;
    CGFloat keyboardViewH = WMKeyboardViewNumberHeight;
    self.numberKeyboardView = [WMKeyboardNumberView keyboardWithFrame:CGRectMake(keyboardViewX, keyboardViewY, keyboardViewW, keyboardViewH)];
    self.otherKeyboardView = [WMKeyboardSpecialView keyboardWithFrame:CGRectMake(keyboardViewX, keyboardViewY, keyboardViewW, keyboardViewH)];
    
    CGFloat keyboardIAViewX = 0;
    CGFloat keyboardIAViewY = 0;
    CGFloat keyboardIAViewW = viewW;
    CGFloat keyboardIAViewH = WMKeyboardIAViewHeight;
    [self.textView.layer setBorderWidth:0.5];
    [self.textView.layer setBorderColor:[[UIColor grayColor] CGColor]];
    [self.textView.layer setCornerRadius:5.0];
    
    WMKeyboardIAView *iaView = [WMKeyboardIAView iaView];
    iaView.delegate = self;
    self.textView.inputAccessoryView = iaView;
    self.textView.inputAccessoryView.frame = CGRectMake(keyboardIAViewX, keyboardIAViewY, keyboardIAViewW, keyboardIAViewH);
    self.textView.inputView = self.otherKeyboardView;
    self.textField.inputView = self.numberKeyboardView;
    
    WS(weakSelf);
    [self.numberKeyboardView setWMKeyboardBlock:^(WMKeyButtonType type, NSString *text) {
        [weakSelf changeTextField:type Text:text];
    }];
    [self.otherKeyboardView setWMKeyboardBlock:^(WMKeyButtonType type, NSString *text) {
        [weakSelf changeTextView:type Text:text];
    }];
}

- (void)backgroundTapped {
    [self.view endEditing:YES];
}

- (void)changeTextField:(WMKeyButtonType)type Text:(NSString *)text {
    switch (type) {
        case WMKeyButtonTypeDel: {
            [self.textField changetext:text];
        }
            break;
            
        case WMKeyButtonTypeDone: {
            [self backgroundTapped];
        }
            break;
            
        case WMKeyButtonTypeOther: {
            [self.textField changetext:text];
        }
            break;
    }
}

- (void)changeTextView:(WMKeyButtonType)type Text:(NSString *)text {
    switch (type) {
        case WMKeyButtonTypeDel: {
            [self.textView changetext:text];
        }
            break;
            
        case WMKeyButtonTypeDone: {
            [self backgroundTapped];
        }
            break;
            
        case WMKeyButtonTypeOther: {
            if (self.currentType == WMKeyboardOtherTypeCommon) {
                [self.otherKeyboardView setButtonsWithType:WMKeyboardOtherTypeCommon];
            }
            [self.textView changetext:text];
        }
            break;
    }
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    [self.numberKeyboardView exchangeNumber];
    return YES;
}

#pragma mark - WMKeyboardIAViewDelegate

- (void)IAViewTypeChanged:(WMKeyboardOtherType)type {
    self.currentType = type;
    [self.otherKeyboardView setButtonsWithType:type];
}

@end
