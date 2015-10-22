//
//  WMKeyboardNumberView.m
//  SelfDefineKeyboard
//
//  Created by wamaker on 15/10/21.
//  Copyright © 2015年 wamaker. All rights reserved.
//

#import "WMKeyButton.h"
#import "WMKeyboardNumberView.h"

#import "UIColor+extension.h"

static NSInteger const kWMKeyboardNumberKeyCount = 12;
static NSInteger const kWMKeyboardNumberDelIndex = 9;
static NSInteger const kWMKeyboardNumberDoneIndex = 11;

@interface WMKeyboardNumberView ()

@property (strong, nonatomic) NSArray *numberKeys;

@property (copy, nonatomic) WMKeyboardBlock block;

@end

@implementation WMKeyboardNumberView

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    
    int row = 4;
    int column = 3;
    
    CGFloat keyWidth = frame.size.width / column;
    CGFloat keyHeight = frame.size.height / row;
    CGFloat keyX = 0;
    CGFloat keyY = 0;
    
    NSMutableArray *array = [NSMutableArray array];
    for (int i = 0; i < kWMKeyboardNumberKeyCount; i++) {
        WMKeyButton *button = [WMKeyButton keyButtonWithFrame:CGRectMake(keyX, keyY, keyWidth, keyHeight)];
        [self addSubview:button];
        WS(weakSelf);
        [button setButtonClickBlock:^(WMKeyButtonType buttonType, NSString *text) {
            weakSelf.block(buttonType, text);
        }];
        [array addObject:button];
        if (i == kWMKeyboardNumberDelIndex) {
            button.type = WMKeyButtonTypeDel;
            [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        } else if (i == kWMKeyboardNumberDoneIndex) {
            button.type = WMKeyButtonTypeDone;
            [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
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
    
    // 水平分隔线
    CGFloat viewX = 0;
    CGFloat viewY = 0;
    CGFloat viewW = frame.size.width;
    CGFloat viewH = 0.5;
    for (int i = 0; i < row; i++) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(viewX, viewY, viewW, viewH)];
        view.backgroundColor = [UIColor colorWithHexString:@"#dfdfdf"];
        [self addSubview:view];
        
        viewY += keyHeight;
    }
    
    // 垂直分隔线
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

- (void)exchangeNumber {
    NSMutableArray *numbers = [NSMutableArray array];
    
    int startNum = 0;
    int length = 10;
    
    for (int i = startNum; i < length; i++) {
        [numbers addObject:[NSString stringWithFormat:@"%d", i]];
    }
    
    for (int i = 0; i < self.numberKeys.count; i++) {
        WMKeyButton *button = self.numberKeys[i];
        
        if (i == kWMKeyboardNumberDelIndex) {
            [button setTitle:DeleteText forState:UIControlStateNormal];
            continue;
        } else if (i == kWMKeyboardNumberDoneIndex) {
            [button setTitle:DoneText forState:UIControlStateNormal];
            continue;
        }
        
        int index = arc4random() % numbers.count;
        [button setTitle:numbers[index] forState:UIControlStateNormal];
        
        [numbers removeObjectAtIndex:index];
    }
}

@end
