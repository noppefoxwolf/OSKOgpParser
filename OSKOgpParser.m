//
//  OSKOgpParser.m
//  OSKOgElementParser
//
//  Created by Tomoya_Hirano on 5/19/15.
//  Copyright (c) 2015 Tomoya_Hirano. All rights reserved.
//

#import "OSKOgpParser.h"

@interface OSKOgpParser ()
@end
@interface OSKOgpObject (){
    NSString*_html;
}
- (instancetype)initWithHTMLString:(NSString*)string;
@property (readonly) NSString *title;
@property (readonly) NSString *type;
@property (readonly) NSString *description;
@property (readonly) NSString *url;
@property (readonly) NSString *image;
@property (readonly) NSString *site_name;
@property (readonly) NSString *email;
- (id)getElementForKey:(NSString*)key;
@end


@implementation OSKOgpParser
+ (void)getOgpElement:(NSURL *)url success:(void (^)(OSKOgpObject *))success failure:(void (^)(NSError *))failure{
    NSURLRequest* myRequest = [NSURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:myRequest
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *resp, NSData *data, NSError *error) {
                               if (error) {
                                   failure(error);
                                   return;
                               }
                               NSString*html = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                               OSKOgpObject*ogp = [[OSKOgpObject alloc] initWithHTMLString:html];
                               success(ogp);
                           }];
}
@end

@implementation OSKOgpObject

- (instancetype)initWithHTMLString:(NSString *)string{
    self = [super init];
    if (self) {
        _html = string;
    }
    return self;
}

- (NSString*)title{return [self getElementForKey:@"title"];}
- (NSString*)type{return [self getElementForKey:@"type"];}
- (NSString*)description{return [self getElementForKey:@"description"];}
- (NSString*)url{return [self getElementForKey:@"url"];}
- (NSString*)image{return [self getElementForKey:@"image"];}
- (NSString*)site_name{return [self getElementForKey:@"site_name"];}
- (NSString*)email{return [self getElementForKey:@"email"];}

- (id)getElementForKey:(NSString *)key{
    if (!_html) {
        return nil;
    }
    NSMutableArray *results = [NSMutableArray new];
    NSString* pattern = [NSString stringWithFormat:@"(<meta.*?property=\\\"og:%@\\\".*?content=\\\")(.*?)(\\\".*?>)",key];
    NSError* error = nil;
    NSRegularExpression* regex = [NSRegularExpression regularExpressionWithPattern:pattern options:NSRegularExpressionCaseInsensitive error:&error];
    if (error == nil){
        NSArray *matches = [regex matchesInString:_html options:0 range:NSMakeRange(0, _html.length)];
        for (NSTextCheckingResult *match in matches){
            [results addObject:[_html substringWithRange:[match rangeAtIndex:2]]];
        }
    }
    if (results.count==0) {
        return nil;
    }
    return [results firstObject];
}

- (NSString*)debugDescription{
    NSString*desc = [NSString stringWithFormat:@"title:%@\ntype:%@\ndescription:%@\nurl:%@\nimage:%@\nsite_name:%@\nemail:%@",self.title,self.type,self.description,self.url,self.image,self.site_name,self.email];
    return desc;
}
@end