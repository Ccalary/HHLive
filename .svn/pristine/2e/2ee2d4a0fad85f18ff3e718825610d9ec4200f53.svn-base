//
//  ApiResultData.m
//  JzyTest
//
//  Created by 姜志远 on 2017/6/2.
//  Copyright © 2017年 姜志远. All rights reserved.
//

#import "ApiResultData.h"

#import "NSObject+Extend.h"

#import "FunUtil.h"

@implementation ApiResultData

-(NSString *)description
{
    NSString *s = @"";
    
    if([FunUtil isNull:self.data] == NO)
    {
        if([self.data isKindOfClass:[NSString class]])
        {
            s = self.data;
        }
        else //if([self.data isKindOfClass:[NSNumber class]])
        {
            s = [NSString stringWithFormat:@"%@", self.data];
        }
    }
    
    
    return [NSString stringWithFormat:@"ApiResultData description : {code:%d,message:%@,data:%@}", self.code,self.message,s];
}

@end
