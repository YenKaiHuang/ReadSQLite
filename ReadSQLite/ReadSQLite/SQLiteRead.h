//
//  SQLiteRead.h
//  ReadSQLite
//
//  Created by yenkai huang on 2014/10/7.
//  Copyright (c) 2014年 yenkai huang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

@interface SQLiteRead : NSObject{
    // Database variables
    NSString *databaseName;
    NSString *databasePath;
    NSString *databaseTable;
}

@property (strong, nonatomic) NSMutableArray *dbItems;

- (id) initWithDBName:(NSString *)dbName tableName:(NSString *)tableName;
- (void) checkAndCreateDatabase;
- (void) readDatabase;
@end
