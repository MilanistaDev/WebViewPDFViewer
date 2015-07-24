//
//  CheckNetWork.m
//  Callrrr SDT
//
//  Created by Takuya Aso on 2015/07/01.
//  Copyright (c) 2015年 SDT-B003. All rights reserved.
//

#import "CheckNetWork.h"

@implementation CheckNetWork

+ (BOOL)checkNetWork {
    
    BOOL checkNum;
    
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus status = [reachability currentReachabilityStatus];
    
    if (status == ReachableViaWiFi) {
        // wifi接続時
        checkNum = YES;
    } else if (status == ReachableViaWWAN) {
        // 3G接続時
        checkNum = YES;
    } else if (status == NotReachable) {
        // 接続不可
        checkNum = NO;
    }
    
    return checkNum;
}

@end
