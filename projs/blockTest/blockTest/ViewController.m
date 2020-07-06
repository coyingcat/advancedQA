//
//  ViewController.m
//  blockTest
//
//  Created by Jz D on 2020/7/6.
//  Copyright © 2020 Jz D. All rights reserved.
//

#import "ViewController.h"

@implementation ViewController




// 有几种 block





//  将变量设置为全局变量
int a_global = 10;


- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view.
    
    
    
    __block int a = 0;
    
    
    //  加 static (放在静态存储区/全局初始化区 )
    //  缺点是, 会永久存储，内存开销大
    static int static_a = 101;
    NSLog(@"a = %d,\n a_global = %d \n, static_a = %d \n", a, a_global, static_a);
    

    void (^foo)(void) = ^{
        a = 1;
        a_global = 20;
        static_a = 200;
    };
    
    foo();
    
    NSLog(@"a = %d,\n a_global = %d \n, static_a = %d \n", a, a_global, static_a);
    
    
    
    
    
    
    
}


- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}


@end
