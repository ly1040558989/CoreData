//
//  Teacher+CoreDataProperties.m
//  CoreData
//
//  Created by 汤来友 on 17/3/2.
//  Copyright © 2017年 tanglaiyou. All rights reserved.
//

#import "Teacher+CoreDataProperties.h"

@implementation Teacher (CoreDataProperties)

+ (NSFetchRequest<Teacher *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Teacher"];
}

@dynamic name;
@dynamic courses;
@dynamic myclass;

@end
