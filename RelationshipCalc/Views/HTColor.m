//
//  HTColor.m
//  tztMobileApp_HTSC
//
//  Created by YeTao on 16/7/5.
//
//

#import "HTColor.h"

@implementation HTColor

+ (UIColor *)colorWithHexString:(NSString *)stringToConvert {
    //去掉前后空格换行符
    NSString *cString = [[stringToConvert stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];

    if ([cString length] < 6) {
        return [UIColor whiteColor];
    }

    if ([cString hasPrefix:@"0X"]) {
        cString = [cString substringFromIndex:2];
    }
    
    else if ([cString hasPrefix:@"#"]) {
        cString = [cString substringFromIndex:1];
    }
    
    if ([cString length] != 6) {
        return [UIColor whiteColor];
    }
    

    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];

    range.location = 2;
    NSString *gString = [cString substringWithRange:range];

    range.location = 4;
    NSString *bString = [cString substringWithRange:range];

    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];

    return [UIColor colorWithRed:r / 255.0 green:g / 255.0 blue:b / 255.0 alpha:1];
}

+ (UIColor *)colorWithHex:(unsigned long)hexValue alpha:(CGFloat)alpha {
    CGFloat red = ((hexValue & 0xFF0000) >> 16);
    CGFloat green = ((hexValue & 0x00FF00) >> 8);
    CGFloat blue = ((hexValue & 0x0000FF) >> 0);
    alpha = MIN(alpha, 1);
    alpha = MAX(0, alpha);
    return [UIColor colorWithRed:red / 255.0 green:green / 255.0 blue:blue / 255.0 alpha:alpha];
}

+ (UIColor *)colorWithHex:(unsigned long)hexValue {
    return [self colorWithHex:hexValue alpha:1];
}

+(NSArray*)ZhiBiaoThemeHQParamColors
{
    static dispatch_once_t onceToken;
    static NSArray *zhibiaoThemeHQColors = nil;
    dispatch_once(&onceToken, ^{
        NSMutableArray *ayColors = [[NSMutableArray alloc] initWithCapacity:7];
        [ayColors addObject:[HTColor colorWithHex:0x989799]];
        [ayColors addObject:[HTColor colorWithHex:0xA77E21]];
        [ayColors addObject:[HTColor colorWithHex:0xAF4049]];
        [ayColors addObject:[HTColor colorWithHex:0x545ee8]];
        [ayColors addObject:[HTColor colorWithHex:0xce4cd6]];
        [ayColors addObject:[HTColor colorWithHex:0xFF8400]];
        [ayColors addObject:[HTColor colorWithHex:0x00E600]];
        
        zhibiaoThemeHQColors = ayColors;
    });
    
    return zhibiaoThemeHQColors;
}

@end
