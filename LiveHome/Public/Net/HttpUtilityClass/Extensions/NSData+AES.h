//
//  NSData+AES.h
//  JzyTest
//
//  Created by 姜志远 on 2017/5/25.
//  Copyright © 2017年 姜志远. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData(AES)


/**
 AES 256

 @param key <#key description#>
 @return <#return value description#>
 */
- (NSData *)AES256EncryptWithKey:(NSString *)key;
- (NSData *)AES256DecryptWithKey:(NSString *)key;


@end
