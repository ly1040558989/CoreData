//
//  ViewController.m
//  CoreData
//
//  Created by 汤来友 on 17/3/2.
//  Copyright © 2017年 tanglaiyou. All rights reserved.
//

#import "ViewController.h"
#import "CollegeManager.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

// Create
- (IBAction)loadData:(UIButton *)sender {
    
    [[CollegeManager sharedManager] initData];
}

// Retrieve
- (IBAction)fetchAllStudent:(UIButton *)sender {
    
    [[CollegeManager sharedManager] fetchMyClasses];
    
}

// Update
- (IBAction)update:(UIButton *)sender {
    [[CollegeManager sharedManager] updateTest];
    
}

// Delete
- (IBAction)delete:(UIButton *)sender {
    [[CollegeManager sharedManager] deleteTest];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
