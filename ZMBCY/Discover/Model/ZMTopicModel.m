//
//  ZMTopicModel.m
//  ZMBCY
//
//  Created by Brance on 2017/11/27.
//  Copyright © 2017年 Brance. All rights reserved.
//

#import "ZMTopicModel.h"

@implementation ZMTopicModel

+ (NSDictionary *)modelCustomPropertyMapper{
    return @{
                @"uid":@"id"
            };
}

- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    NSString *suffix = dic[@"cover"];
    if (![suffix isKindOfClass:[NSString class]]) return NO;
    self.imageSuffix = [suffix componentSeparatedByString:suffix];
    return YES;
}

@end
