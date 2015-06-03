//
//  NSString+QueryString.h
//  MukilApp
//
//  Created by mohamed on 02/06/15.
//  Copyright (c) 2015 mohamed. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (QueryString)

- (NSMutableDictionary *)dictionaryFromQueryStringComponents;

- (NSString *)stringByDecodingURLFormat;

+ (NSString *)getParseUrl:(NSString *)url;

@end
