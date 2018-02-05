//
//  HTColor.h
//  tztMobileApp_HTSC
//
//  Created by YeTao on 16/7/5.
//
//

#import <UIKit/UIKit.h>

#define HTRedColor [HTColor colorWithHex:0xDF3031]

#define RGBCOLOR(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]

#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]

#define UIColorFromRGBWithAlpha(rgbValue,alphaValue) [UIColor colorWithRed:((float)((rgbValue &0xFF0000) >> 16))/255.0 green:((float)((rgbValue &0xFF00) >> 8))/255.0 blue:((float)(rgbValue &0xFF))/255.0 alpha:alphaValue]

@interface HTColor : UIColor

/*!
 *  @brief 转化16进制值字符串[0x1234ab]->UIColor
 *  @param stringToConvert 如: @"0x1234ab" ,@"#1234ab"
 *  @return 16进制值字符串对应的颜色
 *  @code
    [HTColor colorWithHexString:@"0x1234ab"];
 */

+ (UIColor *)colorWithHexString:(NSString *)stringToConvert;
/*!
 *  @brief 转化16进制值[0x1234ab]->UIColor
 *  @param hexValue 如: 0x1234ab
 *  @return 16进制值对应的颜色
 *  @code
    [HTColor colorWithHex:0x1234ab];
 */
+ (UIColor *)colorWithHex:(unsigned long)hexValue;

/*!
 *  @brief 转化16进制值[0x1234ab]->UIColor
 *  @param hexValue 如: 0x1234ab
 *  @param alpha 如: 0.4
 *  @return 16进制值以及alpha对应的颜色
 *  @code
    [HTColor colorWithHex:0x1234ab alpha:0.3];
 */
+ (UIColor *)colorWithHex:(unsigned long)hexValue alpha:(CGFloat)alpha;

/**
 行情相关参数颜色数组

 @return 颜色数组
 */
+ (NSArray *)ZhiBiaoThemeHQParamColors;

@end
