//
//  WMKeyboardInputView.m
//  SelfDefineKeyboard
//
//  Created by wamaker on 15/10/21.
//  Copyright © 2015年 wamaker. All rights reserved.
//

#import "WMKeyboardIAView.h"

@interface WMKeyboardIAView ()

@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedControl;

- (IBAction)changeType:(UISegmentedControl *)sender;

@end

@implementation WMKeyboardIAView

+ (instancetype)iaView {
    return [[self alloc] initIAView];
}

- (instancetype)initIAView {
    if (self = [super init]) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"WMKeyboardIAView" owner:nil options:nil] lastObject];
    }
    return self;
}
- (IBAction)changeType:(UISegmentedControl *)sender {
    if (![self.delegate respondsToSelector:@selector(IAViewTypeChanged:)]) {
        return;
    }
    
    switch ([sender selectedSegmentIndex]) {
        case WMKeyboardOtherTypeCommon: {
            [self.delegate IAViewTypeChanged:WMKeyboardOtherTypeCommon];
        }
            break;
            
        case WMKeyboardOtherTypeAll: {
            [self.delegate IAViewTypeChanged:WMKeyboardOtherTypeAll];
        }
            break;
    }
}

@end
