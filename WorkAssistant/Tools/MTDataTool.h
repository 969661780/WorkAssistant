//
//  MTDataTool.h
//  WorkAssistant
//
//  Created by mt y on 2018/7/11.
//  Copyright © 2018年 mt y. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MTDataTool : NSObject
+ (NSMutableArray *)getAllCardMode:(NSString *)type;
+ (void)putAllCardMode:(NSArray *)arr type:(NSString *)type;
@end
