//
//  Utility.h
//
//  Created by E.Rocchi on 08/01/18.
//
#import <AFNetworking.h>
#import "BaseRequest.h"

@interface Utility : NSObject

+ (NSDictionary *) dictionaryWithPropertiesOfObject:(id)obj;
+ (NSString*)fmtJsonDateToString:(NSTimeInterval)jsonDate;
+ (NSDate*)jsonStringToDate:(NSTimeInterval)jsonDate;
+ (NSDecimalNumber*)jsonStringToDecimalNumber:(NSString*)valore;
+ (NSDecimalNumber*)jsonNumberToDecimalNumber:(NSNumber*)valore;
+ (NSString*)fmtDateToString:(NSDate*)date;
+ (NSString*)fmtDateToStringExt:(NSDate*)date;

@end
