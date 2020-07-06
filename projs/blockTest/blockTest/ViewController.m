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



- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view.
    
    
    
    __block int a = 0;
    
    NSLog(@"a = %d", a);
    
    NSLog(@"\n\n");
    void (^foo)(void) = ^{
        a = 1;
    };
    
    foo();
    
    NSLog(@"a = %d", a);
    
    
    
    
    
    
    
}


- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}


@end
