//
//  WMKeyboardView.m
//  SelfDefineKeyboard
//
//  Created by wamaker on 15/9/27.
//  Copyright (c) 2015年 wamaker. All rights reserved.
//

#import "WMKeyboardView.h"

#import "WMKeyButton.h"

#import "UIColor+extension.h"

@interface WMKeyboardView ()

@property (assign, nonatomic) WMKeyboardType type;

@property (strong, nonatomic) NSArray *numberKeys;
@property (strong, nonatomic) NSArray *textInKeyboardTypeNumber;

@end

@implementation WMKeyboardView

- (instancetype)initWithKeyboardType:(WMKeyboardType)type {
    if (self = [super init]) {
        self.type = type;
        self.backgroundColor = [UIColor colorWithHexString:@"#dfdfdf"];
        
        self.textInKeyboardTypeNumber = @[@"1", @"2", @"3",
                                          @"4", @"5", @"6",
                                          @"7", @"8", @"9",
                                          @"删除", @"0", @"确定"];
    }
    
    return self;
}

+ (instancetype)keyboardViewWithKeyboardType:(WMKeyboardType)type {
    return [[self alloc] initWithKeyboardType:type];
}

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    
    switch (self.type) {
        case WMKeyboardTypeNumber: {
            int row = 4;
            int column = 3;
            
            CGFloat keyWidth = frame.size.width / column;
            CGFloat keyHeight = frame.size.height / row;
            CGFloat keyX = 0;
            CGFloat keyY = 0;
            
            NSMutableArray *array = [NSMutableArray array];
            for (int i = 0; i < self.textInKeyboardTypeNumber.count; i++) {
                WMKeyButton *button = [[WMKeyButton alloc] initWithFrame:CGRectMake(keyX, keyY, keyWidth, keyHeight)];
                [self addSubview:button];
                [array addObject:button];
                if (i == 9) {
                    button.type = WMKeyButtonTypeDel;
                } else if (i == 11) {
                    button.type = WMKeyButtonTypeDone;
                } else {
                    button.type = WMKeyButtonTypeOther;
                }
                
                keyX += keyWidth;
                
                if ((i + 1) % column == 0) {
                    keyX = 0;
                    keyY += keyHeight;
                }
            }
            self.numberKeys = array;
            
            CGFloat viewX = 0;
            CGFloat viewY = keyHeight;
            CGFloat viewW = frame.size.width;
            CGFloat viewH = 0.5;
            for (int i = 0; i < row  - 1; i++) {
                UIView *view = [[UIView alloc] initWithFrame:CGRectMake(viewX, viewY, viewW, viewH)];
                view.backgroundColor = [UIColor colorWithHexString:@"#dfdfdf"];
                [self addSubview:view];
                
                viewY += keyHeight;
            }
            
            viewX = keyWidth;
            viewY = 0;
            viewW = 0.5;
            viewH = frame.size.height;
            for (int i = 0; i < column - 1; i++) {
                UIView *view = [[UIView alloc] initWithFrame:CGRectMake(viewX, viewY, viewW, viewH)];
                view.backgroundColor = [UIColor colorWithHexString:@"#dfdfdf"];
                [self addSubview:view];
                
                viewX += keyWidth;
            }
        }
            break;
            
        case WMKeyboardTypeMore: {
            
        }
            break;
    }
}

- (void)exchangeNumber {
    NSMutableArray *numbers = [NSMutableArray array];
    
    for (int i = 0; i < 10; i++) {
        [numbers addObject:[NSString stringWithFormat:@"%d", i]];
    }
    
    for (int i = 0; i < self.numberKeys.count; i++) {
        WMKeyButton *button = self.numberKeys[i];
        
        if (i == 9 || i == 11) {
            [button setTitle:self.textInKeyboardTypeNumber[i] forState:UIControlStateNormal];
            continue;
        }
        
        int index = arc4random() % numbers.count;
        [button setTitle:numbers[index] forState:UIControlStateNormal];
        
        [numbers removeObjectAtIndex:index];
    }
}

@end
