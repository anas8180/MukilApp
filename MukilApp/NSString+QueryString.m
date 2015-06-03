//
//  NSString+QueryString.m
//  MukilApp
//
//  Created by mohamed on 02/06/15.
//  Copyright (c) 2015 mohamed. All rights reserved.
//

#import "NSString+QueryString.h"

@implementation NSString (QueryString)

- (NSString *)stringByDecodingURLFormat {
    NSString *result = [self stringByReplacingOccurrencesOfString:@"+" withString:@" "];
    result = [result stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    return result;
}

- (NSMutableDictionary *)dictionaryFromQueryStringComponents {
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    for (NSString *keyValue in [self componentsSeparatedByString:@"&"]) {
        NSArray *keyValueArray = [keyValue componentsSeparatedByString:@"="];
        if ([keyValueArray count] < 2) {
            continue;
        }
        
        NSString *key = [[keyValueArray objectAtIndex:0] stringByDecodingURLFormat];
        NSString *value = [[keyValueArray objectAtIndex:1] stringByDecodingURLFormat];
        
        NSMutableArray *results = [parameters objectForKey:key];
        
        if(!results) {
            results = [NSMutableArray arrayWithCapacity:1];
            [parameters setObject:results forKey:key];
        }
        
        [results addObject:value];
    }
    
    return parameters;
}

+ (NSString *)getParseUrl:(NSString *)urlString
{
    NSURL *url = [NSURL URLWithString:urlString];
    
    NSString *URLString = nil;
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData
                                                       timeoutInterval:10];
    [request setHTTPMethod: @"GET"];
    
    NSError *requestError;
    NSURLResponse *urlResponse = nil;
    
    NSData *response1 = [NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&requestError];
    
    NSString* responseString = [[NSString alloc] initWithData:response1 encoding:NSUTF8StringEncoding];
    
    NSString *searchedString = responseString;
    NSRange   searchedRange = NSMakeRange(0, [searchedString length]);
    NSString *pattern = @"url_encoded_fmt_stream_map\": \"(.*?)\"";
    NSError  *error = nil;
    
    NSRegularExpression* regex = [NSRegularExpression regularExpressionWithPattern: pattern options:0 error:&error];
    NSArray* matches = [regex matchesInString:searchedString options:0 range: searchedRange];
    for (NSTextCheckingResult* match in matches) {
        //        NSString* matchText = [searchedString substringWithRange:[match range]];
        NSRange group1 = [match rangeAtIndex:1];
        NSString *parsedStr = [searchedString substringWithRange:group1];
        
        NSArray *fmtStreamMapArray = [parsedStr componentsSeparatedByString:@","];
        NSMutableDictionary *videoDictionary = [NSMutableDictionary dictionary];
        
        for (NSString *videoEncodedString in fmtStreamMapArray) {
            
            NSString *videoString = [videoEncodedString stringByReplacingOccurrencesOfString:@"\\u0026" withString:@"&"];
            
            NSMutableDictionary *videoComponents = [videoString dictionaryFromQueryStringComponents];
            
            NSString *type = [[[videoComponents objectForKey:@"type"] objectAtIndex:0] stringByDecodingURLFormat];
            
            NSString *signature = nil;
            
            if (![videoComponents objectForKey:@"stereo3d"]) {
                if ([videoComponents objectForKey:@"itag"]) {
                    signature = [[videoComponents objectForKey:@"itag"] objectAtIndex:0];
                }
                
                if (signature && [type rangeOfString:@"mp4"].length > 0) {
                    NSString *url = [[[videoComponents objectForKey:@"url"] objectAtIndex:0] stringByDecodingURLFormat];
                    url = [NSString stringWithFormat:@"%@&signature=%@", url, signature];
                    
                    NSString *quality = [[[videoComponents objectForKey:@"quality"] objectAtIndex:0] stringByDecodingURLFormat];
                    if ([videoComponents objectForKey:@"stereo3d"] && [[videoComponents objectForKey:@"stereo3d"] boolValue]) {
                        quality = [quality stringByAppendingString:@"-stereo3d"];
                    }
                    if([videoDictionary valueForKey:quality] == nil) {
                        [videoDictionary setObject:url forKey:quality];
                    }
                }
            }
        }
        
        NSDictionary *qualities = videoDictionary;
        
        if ([qualities objectForKey:@"medium"] != nil) {
            URLString = [qualities objectForKey:@"medium"];
        }
        else if ([qualities objectForKey:@"small"] != nil) {
            URLString = [qualities objectForKey:@"small"];
        }
        else if ([qualities objectForKey:@"hd720"] != nil) {
            URLString = [qualities objectForKey:@"hd720"];
        }
        else if ([qualities objectForKey:@"live"] != nil) {
            URLString = [qualities objectForKey:@"live"];
        }
        else {
            URLString = @"";
        }
    }
    
    return URLString;
}

@end
