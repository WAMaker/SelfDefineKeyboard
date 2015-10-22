//
//  WMKeyboardView.m
//  SelfDefineKeyboard
//
//  Created by wamaker on 15/9/27.
//  Copyright (c) 2015年 wamaker. All rights reserved.
//

#import "WMKeyboardView.h"

@interface WMKeyboardView ()

@property (copy, nonatomic) WMKeyboardBlock block;

@end

@implementation WMKeyboardView

- (instancetype)initKeyboardWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
    }
    return self;
}

+ (instancetype)keyboardWithFrame:(CGRect)frame {
    return [[self alloc] initKeyboardWithFrame:frame];
}

- (void)setWMKeyboardBlock:(WMKeyboardBlock)block {
    self.block = block;
}

@end
