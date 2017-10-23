//
//  CollegeManager.m
//  UseCoreData
//
//  Created by 汤来友 on 17/3/2.
//  Copyright © 2017年 tanglaiyou. All rights reserved.
//

#import "CollegeManager.h"
#import "AppDelegate.h"
#import "Teacher+CoreDataClass.h"
#import "Student+CoreDataClass.h"
#import "Course+CoreDataClass.h"
#import "MyClass+CoreDataClass.h"

#import "Teacher+CoreDataProperties.h"
#import "Student+CoreDataProperties.h"
#import "Course+CoreDataProperties.h"
#import "MyClass+CoreDataProperties.h"


@implementation CollegeManager {
    AppDelegate* appDelegate;
    NSManagedObjectContext* appContext;
}


+ (CollegeManager*)sharedManager{
    static CollegeManager* _sharedManager = nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        _sharedManager = [[self alloc] init];
    });
    return _sharedManager;
}

- (id)init{
    self = [super init];
    appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    appContext = appDelegate.managedObjectContext;
    return self;
}

- (void)save{
    [appDelegate saveContext];
}

- (void)deleteEntity:(NSManagedObject*)obj{
    [appContext deleteObject:obj];
    [self save];
}


// 加载数据
- (void)initData
{
    //插入一些班级实体
    //这个Mutable Array是为了方便后面建立实体关系使用（后面的也是）
    NSMutableArray* arrMyClasses = [[NSMutableArray alloc] init];
    NSArray* arrMyClassesName = @[@"99级1班",@"99级2班",@"99级3班"];
    for (NSString* className in arrMyClassesName) {
        MyClass* newMyClass = [NSEntityDescription insertNewObjectForEntityForName:@"MyClass" inManagedObjectContext:appContext];
        newMyClass.name = className;
        [arrMyClasses addObject:newMyClass];
    }
    
    //插入一些学生实体
    NSMutableArray *arrStudents = [[NSMutableArray alloc] init];
    NSArray *studentInfo = @[
                             @{@"name":@"李斌", @"age":@20},
                             @{@"name":@"李鹏", @"age":@19},
                             @{@"name":@"朱文", @"age":@21},
                             @{@"name":@"李强", @"age":@21},
                             @{@"name":@"高崇", @"age":@18},
                             @{@"name":@"薛大", @"age":@19},
                             @{@"name":@"裘千仞", @"age":@21},
                             @{@"name":@"王波", @"age":@18},
                             @{@"name":@"王鹏", @"age":@19},
                             ];
    for (id info in studentInfo) {
        NSString* name = [info objectForKey:@"name"];
        NSNumber* age = [info objectForKey:@"age"];
        Student* newStudent = [NSEntityDescription insertNewObjectForEntityForName:@"Student" inManagedObjectContext:appContext];
        newStudent.name = name;
        newStudent.age = age;
        [arrStudents addObject:newStudent];
    }
    
    //插入一些教师实体
    NSMutableArray* arrTeachers = [[NSMutableArray alloc] init];
    NSArray* arrTeachersName = @[@"王刚",@"谢力",@"徐开义",@"许宏权"];
    for (NSString* teacherName in arrTeachersName) {
        Teacher* newTeacher = [NSEntityDescription insertNewObjectForEntityForName:@"Teacher" inManagedObjectContext:appContext];
        newTeacher.name = teacherName;
        [arrTeachers addObject:newTeacher];
    }
    
    //插入一些课程实体
    NSMutableArray* arrCourses = [[NSMutableArray alloc] init];
    NSArray* arrCoursesName = @[@"CAD",@"软件工程",@"线性代数",@"微积分",@"大学物理"];
    for (NSString* courseName in arrCoursesName) {
        Course* newCourse = [NSEntityDescription insertNewObjectForEntityForName:@"Course" inManagedObjectContext:appContext];
        newCourse.name = courseName;
        [arrCourses addObject:newCourse];
    }
    
    //创建学生和班级的关系
    //往班级1中加入几个学生（方法有多种）
    MyClass* classOne = [arrMyClasses objectAtIndex:0];
    [classOne addStudentsObject:[arrStudents objectAtIndex:0]];
    [classOne addStudentsObject:[arrStudents objectAtIndex:1]];
    [[arrStudents objectAtIndex:2] setMyclass:classOne]; //或者这样也可以
    //往班级2中加入几个学生（用不同方法）
    MyClass* classTwo = [arrMyClasses objectAtIndex:1];
    [classTwo addStudents:[NSSet setWithArray:[arrStudents subarrayWithRange:NSMakeRange(3, 3)]]];
    //往班级3中加入几个学生（再用不同的方法）
    MyClass* classThree = [arrMyClasses objectAtIndex:2];
    [classThree setStudents:[NSSet setWithArray:[arrStudents subarrayWithRange:NSMakeRange(6, 3)]]];
    
    //给三个班指派班主任
    Teacher* wanggang = [arrTeachers objectAtIndex:0];
    Teacher* xieli = [arrTeachers objectAtIndex:1];
    Teacher* xukaiyi = [arrTeachers objectAtIndex:2];
    Teacher* xuhongquan = [arrTeachers objectAtIndex:3];
    
    [classOne setTeacher:wanggang];
    classTwo.teacher = xieli; //或这样（可能不太好）
    [xukaiyi setMyclass:classThree]; //或这样反过来也行
   
    
    //创建教师和课程的对应关系
    Course* cad = [arrCourses objectAtIndex:0];
    Course* software = [arrCourses objectAtIndex:1];
    Course* linear = [arrCourses objectAtIndex:2];
    Course* calculus = [arrCourses objectAtIndex:3];
    Course* physics = [arrCourses objectAtIndex:4];
    [wanggang setCourses:[NSSet setWithObjects:cad, software, nil]];
    [linear setTeacher:xieli];
    [calculus setTeacher:xuhongquan];
    [physics setTeacher:xukaiyi];
    
    //设置学生所选修的课程
    [[arrStudents objectAtIndex:0] setCourses:[NSSet setWithObjects:cad, software, nil]];
    [[arrStudents objectAtIndex:1] setCourses:[NSSet setWithObjects:cad, linear, nil]];
    [[arrStudents objectAtIndex:2] setCourses:[NSSet setWithObjects:linear, physics, nil]];
    [[arrStudents objectAtIndex:3] setCourses:[NSSet setWithObjects:physics, cad, nil]];
    [[arrStudents objectAtIndex:4] setCourses:[NSSet setWithObjects:calculus, physics, nil]];
    [[arrStudents objectAtIndex:5] setCourses:[NSSet setWithObjects:software, linear, nil]];
    [[arrStudents objectAtIndex:6] setCourses:[NSSet setWithObjects:software, physics, nil]];
    [[arrStudents objectAtIndex:7] setCourses:[NSSet setWithObjects:linear, software, nil]];
    [[arrStudents objectAtIndex:8] setCourses:[NSSet setWithObjects:calculus, software, cad, nil]];
    
    //保存
    //如不保存，上面的所有动作都不会写入sqlite
    NSError* error;
    [appContext save:&error];
    if (error!=nil) {
        NSLog(@"%@",error);
    }
}


- (void)fetchTest
{
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Student" inManagedObjectContext:appContext];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDescription];
    
    // 排序 (按年龄对学生进行升序排序)
    NSSortDescriptor* sorting = [NSSortDescriptor sortDescriptorWithKey:@"age" ascending:YES];
    [request setSortDescriptors:[NSArray arrayWithObject:sorting]];
    
    // 过滤 (查询出所有姓李的学生)
    NSPredicate *filter = [NSPredicate predicateWithFormat:@"name BEGINSWITH '李'"];
    [request setPredicate:filter];
    

    NSError *error = nil;
    NSArray *arrStudents = [appContext executeFetchRequest:request error:&error];
    if (error!=nil) {
        NSLog(@"%@",error);
    }
    else{
        for (Student* stu in arrStudents) {
            NSLog(@"%@ (%@岁)",stu.name,stu.age);
        }
    }
}

- (void)fetchMyClasses
{
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"MyClass" inManagedObjectContext:appContext];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDescription];
    
    //
    [request setRelationshipKeyPathsForPrefetching:[NSArray arrayWithObjects:@"students",nil]];
    
    NSError *error = nil;
    NSArray *arrClasses = [appContext executeFetchRequest:request error:&error];
    if (error!=nil) {
        NSLog(@"%@",error);
    }
    else{
        for (MyClass* myclass in arrClasses) {
            NSLog(@"%@",myclass.name);
            for (Student* student in myclass.students) {
                NSLog(@"    %@", student.name);
            }
        }
    }
}



/*
 修改和删除其实比前面提到的查询反而简单。
 
 修改的方法：1，获取到要修改的Entity；2，修改其属性或关系；3，save。
 删除的方法：1，获取到要删除的Entity；2，删除之；3，save。
 */

- (void)updateTest
{
    //将“CAD”这门课的名称改为“CAD设计”，并将其授课教师改为“许宏权”
    
    //查出Teacher
    //NSEntityDescription* entityDescription = [NSEntityDescription entityForName:@"Teacher" inManagedObjectContext:appContext];
    //[request setEntity:entityDescription];
    //前面这两步可以换成下面的一步
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Teacher"];
    NSPredicate *filter = [NSPredicate predicateWithFormat:@"name = '许宏权'"];
    [request setPredicate:filter];
    NSError *error = nil;
    NSArray *arrResult = [appContext executeFetchRequest:request error:&error];
    Teacher* xuhongquan = [arrResult objectAtIndex:0];
    
    //查出Course
    request = [NSFetchRequest fetchRequestWithEntityName:@"Course"];
    filter = [NSPredicate predicateWithFormat:@"name =[cd] 'cad'"]; //这里的[cd]表示大小写和音标不敏感
    [request setPredicate:filter];
    arrResult = [appContext executeFetchRequest:request error:&error];
    Course* cad = [arrResult objectAtIndex:0];
    
    // 多条件查询用 && 连接
    
    //修改
    [cad setName:@"CAD设计"];
    [cad setTeacher:xuhongquan];
    
    //保存
    [self save];
}


- (void)deleteTest
{
    //删除学生“王波”
    //查询出“王波”
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Student"];
    NSPredicate *filter = [NSPredicate predicateWithFormat:@"name = '王波'"];
    [request setPredicate:filter];
    NSError *error = nil;
    NSArray *arrResult = [appContext executeFetchRequest:request error:&error];
    Student* wangbo = [arrResult objectAtIndex:0];
    //执行删除
    [self deleteEntity:wangbo];
    //保存
    [self save];
    
    //删除“99届2班”
    request = [NSFetchRequest fetchRequestWithEntityName:@"MyClass"];
    filter = [NSPredicate predicateWithFormat:@"name = '99级2班'"];
    [request setPredicate:filter];
    arrResult = [appContext executeFetchRequest:request error:&error];
    MyClass* myClassTwo = [arrResult objectAtIndex:0];
    //执行删除
    //注意！由于设置了删除规则为Cascade，所以“99届2班”的所有学生也会被同时删除掉
    [self deleteEntity:myClassTwo];
    //保存（其实也可以一起保存）
    [self save];
    
    //删除教师“徐开义”
    request = [NSFetchRequest fetchRequestWithEntityName:@"Teacher"];
    filter = [NSPredicate predicateWithFormat:@"name='徐开义'"];
    [request setPredicate:filter];
    arrResult = [appContext executeFetchRequest:request error:&error];
    Teacher* teacher = [arrResult objectAtIndex:0];
    //执行删除
    //注意！由于设置了删除规则为Cascade，所以“徐开义”的课程也会被删掉
    [self deleteEntity:teacher];
    //保存
    [self save];
}


@end
