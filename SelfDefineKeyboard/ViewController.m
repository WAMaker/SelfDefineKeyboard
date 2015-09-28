//
//  ViewController.m
//  SelfDefineKeyboard
//
//  Created by wamaker on 15/9/10.
//  Copyright (c) 2015年 wamaker. All rights reserved.
//

#import "ViewController.h"

#import "WMKeyboardView.h"

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
    CGFloat keyboardViewH = 250;
    self.keyboardView = [WMKeyboardView keyboardViewWithKeyboardType:WMKeyboardTypeNumber];
    self.keyboardView.frame = CGRectMake(keyboardViewX, keyboardViewY, keyboardViewW, keyboardViewH);
    self.textField.inputView = self.keyboardView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Private

- (void)backgroundTapped {
    [self.view endEditing:YES];
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    [self.keyboardView exchangeNumber];
    return YES;
}

@end
