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
    
    NSString *databasePathFromApp;
    
    NSString *documentsDir;
    NSFileManager *fileManager;
}

@property (strong, nonatomic) NSMutableArray *dbItems;

/**
 * @brief Initial SQLiteRead with database name and table name.
 * @param dbName database name.
 * @param tableName table name
 */
- (id) initWithDBName:(NSString *)dbName tableName:(NSString *)tableName;

/**
 * @brief check database update necessary 
 */
- (BOOL) checkDatabaseUpdate;

/**
 * @brief check database is exist, it not create a copy in Document folder.
 */
- (void) checkAndCreateDatabase;

/**
 * parse database and add item in dbItems array.
 */
- (void) readDatabase;
@end
