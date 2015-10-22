//
//  WMKeyboardOtherView.m
//  SelfDefineKeyboard
//
//  Created by wamaker on 15/10/21.
//  Copyright © 2015年 wamaker. All rights reserved.
//

#import "WMKeyButton.h"
#import "WMKeySpecialButton.h"
#import "WMKeyboardSpecialView.h"

#import "Button.h"
#import "CoreDataStack.h"

#import "WMKeyboardDefine.h"

static CGFloat const kWMKeyboardOtherViewDDBtnHeight = 45;

@interface WMKeyboardSpecialView ()

@property (copy, nonatomic) WMKeyboardBlock block;

@property (weak, nonatomic) WMKeyButton *doneButton;
@property (weak, nonatomic) WMKeyButton *delButton;
@property (weak, nonatomic) UIScrollView *scrollView;

@property (strong, nonatomic) CoreDataStack *stack;

@end

@implementation WMKeyboardSpecialView

- (instancetype)initKeyboardWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.stack = [CoreDataStack sharedInstance];
        
        [self layoutViews];
    }
    
    return self;
}

- (void)layoutViews {
    WS(weakSelf);
    
    CGFloat viewWidth = CGRectGetWidth(self.frame);
    CGFloat viewHeight = CGRectGetHeight(self.frame);
    
    CGFloat delButtonX = 0;
    CGFloat delButtonY = viewHeight - kWMKeyboardOtherViewDDBtnHeight;
    CGFloat delButtonW = viewWidth / 2;
    CGFloat delButtonH = kWMKeyboardOtherViewDDBtnHeight;
    WMKeyButton *delButton = [WMKeyButton keyButtonWithFrame:CGRectMake(delButtonX, delButtonY, delButtonW, delButtonH)];
    delButton.type = WMKeyButtonTypeDel;
    [delButton setTitle:DeleteText forState:UIControlStateNormal];
    [delButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [delButton setButtonClickBlock:^(WMKeyButtonType buttonType, NSString *text) {
        weakSelf.block(buttonType, text);
    }];
    [self addSubview:delButton];
    self.delButton = delButton;
    
    CGFloat doneButtonX = viewWidth / 2;
    CGFloat doneButtonY = delButtonY;
    CGFloat doneButtonW = delButtonW;
    CGFloat doneButtonH = kWMKeyboardOtherViewDDBtnHeight;
    WMKeyButton *doneButton = [WMKeyButton keyButtonWithFrame:CGRectMake(doneButtonX, doneButtonY, doneButtonW, doneButtonH)];
    doneButton.type = WMKeyButtonTypeDone;
    [doneButton setTitle:DoneText forState:UIControlStateNormal];
    [doneButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [doneButton setButtonClickBlock:^(WMKeyButtonType buttonType, NSString *text) {
        weakSelf.block(buttonType, text);
    }];
    [self addSubview:doneButton];
    self.doneButton = doneButton;
    
    CGFloat padding = 20;
    CGFloat scrollViewX = padding;
    CGFloat scrollViewY = padding;
    CGFloat scrollViewW = viewWidth - 2 * padding;
    CGFloat scrollViewH = viewHeight - kWMKeyboardOtherViewDDBtnHeight - 2 * padding;
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(scrollViewX, scrollViewY, scrollViewW, scrollViewH)];
    [self addSubview:scrollView];
    self.scrollView = scrollView;
    
    [self setButtonsWithType:WMKeyboardOtherTypeCommon];
}

- (void)setButtonsWithType:(WMKeyboardOtherType)type {
    [self.scrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:CoreDataStackButton];
    NSError *error = nil;
    
    switch (type) {
        case WMKeyboardOtherTypeCommon: {
            fetchRequest.predicate = [NSPredicate predicateWithFormat:@"count > 0"];
            fetchRequest.sortDescriptors = @[
                                             [NSSortDescriptor sortDescriptorWithKey:@"count" ascending:NO]
                                             ];
        }
            break;
            
        case WMKeyboardOtherTypeAll: {
            
        }
            break;
    }
    
    NSArray *results = [self.stack.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    
    CGFloat buttonpadding = 10;
    CGFloat buttonX = 0;
    CGFloat buttonY = 0;
    CGFloat buttonH = 30;
    CGFloat maxY = buttonH;
    CGFloat scrollViewW = [UIScreen mainScreen].bounds.size.width - 40;
    CGFloat widthLeft = [UIScreen mainScreen].bounds.size.width - 40;
    
    WS(weakSelf);
    NSDictionary *attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:WMKeyButtonFont]};
    for (Button *button in results) {
        CGSize tSize = [button.text boundingRectWithSize:CGSizeMake(scrollViewW, buttonH)
                                                 options:NSStringDrawingUsesLineFragmentOrigin
                                              attributes:attribute
                                                 context:nil].size;
        CGFloat buttonW = tSize.width + 2 * buttonpadding;
        
        if (buttonW + buttonpadding > widthLeft) {
            widthLeft = scrollViewW;
            buttonX = 0;
            buttonY += buttonH + buttonpadding;
            maxY += buttonH + buttonpadding;
        }
        
        WMKeySpecialButton *keyButton = [WMKeySpecialButton keyButtonWithFrame:CGRectMake(buttonX, buttonY, buttonW, buttonH)];
        keyButton.type = WMKeyButtonTypeOther;
        keyButton.button = button;
        [keyButton setTitle:button.text forState:UIControlStateNormal];
        [keyButton setSButtonClickBlock:^(WMKeyButtonType buttonType, NSString *text, Button *button) {
            button.count = [NSNumber numberWithInteger:[button.count integerValue] + 1];
            [weakSelf.stack saveContext];
            NSLog(@"%@ %@", button.text, button.count);
            weakSelf.block(buttonType, text);
        }];
        [self.scrollView addSubview:keyButton];
        
        widthLeft -= buttonW + buttonpadding;
        buttonX = scrollViewW - widthLeft;
    }
    
    self.scrollView.contentSize = CGSizeMake(scrollViewW, maxY);
}

@end
