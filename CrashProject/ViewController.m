//
//  ViewController.m
//  CrashProject
//
//  Created by Hosel on 2017/8/3.
//  Copyright © 2017年 Hosel. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:@"明",@"name",nil];
    NSMutableArray *array = [NSMutableArray array];
    [array addObject:dic];
    NSDictionary *dic1 = array[1];
    NSLog(@"%@",dic1);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
