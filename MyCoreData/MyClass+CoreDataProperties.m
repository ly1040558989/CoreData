//
//  MyClass+CoreDataProperties.m
//  CoreData
//
//  Created by 汤来友 on 17/3/2.
//  Copyright © 2017年 tanglaiyou. All rights reserved.
//

#import "MyClass+CoreDataProperties.h"

@implementation MyClass (CoreDataProperties)

+ (NSFetchRequest<MyClass *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"MyClass"];
}

@dynamic name;
@dynamic students;
@dynamic teacher;

@end
