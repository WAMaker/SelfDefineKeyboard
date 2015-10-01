//
//  WMKeyKeyboardDefine.h
//  SelfDefineKeyboard
//
//  Created by wamaker on 15/9/30.
//  Copyright (c) 2015年 wamaker. All rights reserved.
//

typedef enum : NSUInteger {
    WMKeyboardTypeNumber, // 键盘类型：纯数字
    WMKeyboardTypeMore    // 键盘类型：更多
} WMKeyboardType;

typedef enum : NSUInteger {
    WMKeyButtonTypeDel,   // 按键类型：删除
    WMKeyButtonTypeDone,  // 按键类型：完成
    WMKeyButtonTypeOther  // 按键类型：其他
} WMKeyButtonType;