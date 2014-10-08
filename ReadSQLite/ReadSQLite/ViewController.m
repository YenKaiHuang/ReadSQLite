//
//  ViewController.m
//  ReadSQLite
//
//  Created by yenkai huang on 2014/10/7.
//  Copyright (c) 2014年 yenkai huang. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    SQLiteRead *sqlRead = [[SQLiteRead alloc] initWithDBName:@"IRDB.sqlite" tableName:@"ZIRCODETABLE"];
    [sqlRead checkAndCreateDatabase];
    [sqlRead readDatabase];
    
    NSLog(@"dbItems = %@", sqlRead.dbItems);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
