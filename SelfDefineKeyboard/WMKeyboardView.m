//
//  WMKeyboardView.m
//  SelfDefineKeyboard
//
//  Created by wamaker on 15/9/27.
//  Copyright (c) 2015年 wamaker. All rights reserved.
//

#import "WMKeyboardView.h"

#import "UIColor+extension.h"

@interface WMKeyboardView ()

@property (assign, nonatomic) WMKeyboardType type;

@end

@implementation WMKeyboardView

- (instancetype)initWithKeyboardType:(WMKeyboardType)type {
    if (self = [super init]) {
        self.type = type;
        self.backgroundColor = [UIColor colorWithHexString:@"#dfdfdf"];
    }
    
    return self;
}

+ (instancetype)keyboardViewWithKeyboardType:(WMKeyboardType)type {
    return [[self alloc] initWithKeyboardType:type];
}

@end
