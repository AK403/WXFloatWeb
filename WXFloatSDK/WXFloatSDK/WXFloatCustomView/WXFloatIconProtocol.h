//
//  WXFloatIconProtocol.h
//  WXFloatSDK
//
//  Created by AK403 on 2018/9/2.
//  Copyright © 2018年 AK403. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol WXFloatIconProtocol <NSObject>

+ (CGRect)floatIconFrame;

@property (nonatomic, strong) UIImageView *imageView;
@end
