//
//  COBaseDomain.m
//  COTools
//
//  Created by carlos on 13-12-19.
//  Copyright (c) 2013年 carlosk. All rights reserved.
//

#import "COBaseDomain.h"
#import "COCommTool.h"
#import <objc/runtime.h>
@implementation COBaseDomain
-(id)initWithJson:(NSDictionary *)json{
    self = [super init];
    if (!self) {
        return self;
    }
    
    [COCommTool fillObject:self withJSONDict:json];
    
    return self;
}
- (void)encodeWithCoder:(NSCoder *)aCoder
{
    
    unsigned int outCount, i;
    objc_property_t *properties = class_copyPropertyList([self class], &outCount);
    for (i = 0; i < outCount; i++) {
        objc_property_t property = properties[i];
        NSString *key = [NSString stringWithFormat:@"%s",property_getName(property)];
        id value = [self valueForKey:key];
        [aCoder encodeObject:value forKey:[NSString stringWithFormat:@"co_%@",key]];
    }
    free (properties);
}


- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if(self)
    {
        
        unsigned int outCount, i;
        objc_property_t *properties = class_copyPropertyList([self class], &outCount);
        for (i = 0; i < outCount; i++) {
            objc_property_t property = properties[i];
            NSString *key1 = [NSString stringWithFormat:@"%s",property_getName(property)];
            NSString *key2 = [NSString stringWithFormat:@"co_%@",key1];
            id value = [aDecoder decodeObjectForKey:key2];
            [self setValue:value forKey:key1];
        }
        free (properties);
    }
    return self;
}


- (NSString *)description{
    NSMutableString *result = [NSMutableString stringWithString:@""];
    //形参
    [result appendFormat:@"%s [",class_getName([self class])];
    unsigned int outCount, i;
    objc_property_t *properties = class_copyPropertyList([self class], &outCount);
    for (i = 0; i < outCount; i++) {
        objc_property_t property = properties[i];
        NSString *key = [NSString stringWithFormat:@"%s",property_getName(property)];
        NSString *value = [self valueForKey:key];
        if (i == outCount -1) {
            [result appendFormat:@"%@=%@",key,value];
        }else{
            [result appendFormat:@"%@=%@,",key,value];
        }
    }
    free (properties);
    [result appendString:@"]"];
    
    return result;
}

@end
