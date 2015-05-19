//
//  OSKOgpParser.h
//  OSKOgElementParser
//
//  Created by Tomoya_Hirano on 5/19/15.
//  Copyright (c) 2015 Tomoya_Hirano. All rights reserved.
//

#import <Foundation/Foundation.h>
@class OSKOgpObject;
@interface OSKOgpParser : NSObject
+ (void)getOgpElement:(NSURL*)url
              success:(void(^)(OSKOgpObject*object))success
              failure:(void(^)(NSError*error))failure;
+ (OSKOgpObject*)getOgpElementWithHTML:(NSString*)html;
@end
@interface OSKOgpObject : NSObject
@end
