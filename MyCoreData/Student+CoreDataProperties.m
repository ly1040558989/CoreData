//
//  Student+CoreDataProperties.m
//  CoreData
//
//  Created by 汤来友 on 17/3/2.
//  Copyright © 2017年 tanglaiyou. All rights reserved.
//

#import "Student+CoreDataProperties.h"

@implementation Student (CoreDataProperties)

+ (NSFetchRequest<Student *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Student"];
}

@dynamic name;
@dynamic age;
@dynamic myclass;
@dynamic courses;

@end
