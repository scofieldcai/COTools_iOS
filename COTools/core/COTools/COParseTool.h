//
//  COParseTool.h
//  COToolsSample
//
//  Created by carlos on 14-1-5.
//  Copyright (c) 2014年 carlosk. All rights reserved.
//

#import "COBaseTool.h"

@interface COParseTool : COBaseTool
//根据json字符串解析成对象
+(NSArray *)parserData:(NSString *)jsonContent withClass:(Class)mClass withKey:(NSString *)key;

//根据json字符串解析成对象
+(id)parser:(NSString *)jsonContent withClass:(Class)mClass withKey:(NSString *)key;
//通过key查找value
+(NSString *)parseValueWith:(NSString *)jsonContent withKey:(NSString *)key;
@end
