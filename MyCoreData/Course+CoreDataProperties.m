//
//  Course+CoreDataProperties.m
//  CoreData
//
//  Created by 汤来友 on 17/3/2.
//  Copyright © 2017年 tanglaiyou. All rights reserved.
//

#import "Course+CoreDataProperties.h"

@implementation Course (CoreDataProperties)

+ (NSFetchRequest<Course *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Course"];
}

@dynamic name;
@dynamic students;
@dynamic teacher;

@end
