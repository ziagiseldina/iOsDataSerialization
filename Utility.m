//
//  Utility.m
//
//  Created by E.Rocchi on 08/01/18.
//

#import <Foundation/Foundation.h>
#import "Utility.h"
#import <objc/runtime.h>

@implementation Utility

//Add this utility method in your class.
+ (NSDictionary *) dictionaryWithPropertiesOfObject:(id)obj
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    
    unsigned count;
    objc_property_t *properties = class_copyPropertyList([obj class], &count);
    
    for (int i = 0; i < count; i++) {
        NSString *key = [NSString stringWithUTF8String:property_getName(properties[i])];
       
        
        Class classObject = [[obj valueForKey:key] class]; // NSClassFromString(tmp);
        id object = [obj valueForKey:key];
        
        if (classObject && ![object isKindOfClass:[NSString class]] && ![object isKindOfClass:[NSDecimalNumber class]] && ![object isKindOfClass:[NSNumber class]] &&  ![object isKindOfClass:[NSArray class]] &&  ![object isKindOfClass:[NSMutableArray class]]) {
            id subObj = [self dictionaryWithPropertiesOfObject:object];
            [dict setObject:subObj forKey:key];
        }
        else if([object isKindOfClass:[NSArray class]] || [object isKindOfClass:[NSMutableArray class]])
        {
            NSMutableArray *subObj = [NSMutableArray array];
            for (id o in object) {
                [subObj addObject:[self dictionaryWithPropertiesOfObject:o] ];
            }
            [dict setObject:subObj forKey:key];
        }
        else if(![object isKindOfClass:[NSString class]] && ![object isKindOfClass:[NSDecimalNumber class]] && ![object isKindOfClass:[NSNumber class]])
        {
            id subObj = [self dictionaryWithPropertiesOfObject:object];
            [dict setObject:subObj forKey:key];
        }
        else
        {
            if(object) [dict setObject:object forKey:key];
        }
    }
    
    free(properties);
    
    return [NSDictionary dictionaryWithDictionary:dict];
}

+ (NSString*)fmtJsonDateToString:(NSTimeInterval)jsonDate
{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:(jsonDate / 1000.0) ];
    
    NSDateFormatter *newDateFormatter = [[NSDateFormatter alloc]init];
    [newDateFormatter setDateFormat:@"dd/MM/yyyy"];
    NSString *newString = [newDateFormatter stringFromDate:date];
    // NSLog(@"Date: %@, formatted date: %@", date, newString);
    return newString;
}

+ (NSDate*)jsonStringToDate:(NSTimeInterval)jsonDate
{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:jsonDate];
    
    return date;
}

+ (NSDecimalNumber*)jsonStringToDecimalNumber:(NSString*)valore
{
    NSDecimalNumber *zero = [NSDecimalNumber zero];
    if(valore != nil && ![valore isEqualToString:@""])
    {
        zero = (NSDecimalNumber*) [NSDecimalNumber decimalNumberWithString:valore];
    }
    
    return zero;
}
+ (NSDecimalNumber*)jsonNumberToDecimalNumber:(NSNumber*)valore
{
    NSDecimalNumber *d = [NSDecimalNumber decimalNumberWithDecimal:[valore decimalValue]];
    return d;
}

+ (NSString*)fmtDateToString:(NSDate*)date
{
    NSDateFormatter *newDateFormatter = [[NSDateFormatter alloc]init];
    [newDateFormatter setDateFormat:@"dd/MM/yyyy"];
    NSString *newString = [newDateFormatter stringFromDate:date];
    return newString;
}

+ (NSString*)fmtDateToStringExt:(NSDate*)date
{
    NSDateFormatter *newDateFormatter = [[NSDateFormatter alloc]init];
    [newDateFormatter setDateFormat:@"dd/MM/yyyy HH:mm"];
    NSString *newString = [newDateFormatter stringFromDate:date];
    return newString;
}

@end
