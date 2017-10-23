//
//  CollegeManager.h
//  UseCoreData
//
//  Created by 汤来友 on 17/3/2.
//  Copyright © 2017年 tanglaiyou. All rights reserved.
//

#import <Foundation/Foundation.h>
@class NSManagedObject;


@interface CollegeManager : NSObject

+ (CollegeManager*)sharedManager;

- (void)save;
- (void)deleteEntity:(NSManagedObject*)obj;
- (void)initData;

// 查询所有学生
- (void)fetchTest;

// 查询所有班级，并逐个打印出班级的全体学生
- (void)fetchMyClasses;

- (void)updateTest;

- (void)deleteTest;

@end
