//
//  CheckNetWork.h
//  Callrrr SDT
//
//  Created by Takuya Aso on 2015/07/01.
//  Copyright (c) 2015年 SDT-B003. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Reachability.h"

@interface CheckNetWork : NSObject {
    
    Reachability *networkStatus;
}

+ (BOOL)checkNetWork;


@end
