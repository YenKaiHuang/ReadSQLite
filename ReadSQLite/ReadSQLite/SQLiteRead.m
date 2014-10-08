//
//  SQLiteRead.m
//  ReadSQLite
//
//  Created by yenkai huang on 2014/10/7.
//  Copyright (c) 2014年 yenkai huang. All rights reserved.
//

#import "SQLiteRead.h"

@implementation SQLiteRead

- (id) initWithDBName:(NSString *)dbName tableName:(NSString *)tableName {
    self = [super init];
    if (self) {
        databaseName = dbName;
        
        databaseTable = tableName;
        
        // Get the path to the documents directory and append the databaseName
        NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDir = [documentPaths objectAtIndex:0];
        databasePath = [documentsDir stringByAppendingPathComponent:databaseName];
        
        NSLog(@"databasePath = %@", databasePath);
    }
    return self;
}


-(void) checkAndCreateDatabase{
    // Check if the SQL database has already been saved to the users phone, if not then copy it over
    BOOL success;
    
    // Create a FileManager object, we will use this to check the status
    // of the database and to copy it over if required
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    // Check if the database has already been created in the users filesystem
    success = [fileManager fileExistsAtPath:databasePath];
    
    // If the database already exists then return without doing anything
    if(success) return;
    
    // If not then proceed to copy the database from the application to the users filesystem
    
    // Get the path to the database in the application package
    NSString *databasePathFromApp = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:databaseName];
    
    // Copy the database from the package to the users filesystem
    [fileManager copyItemAtPath:databasePathFromApp toPath:databasePath error:nil];
}


- (void) readDatabase {
    NSLog(@"readDatabase");
    // Setup the database object
    sqlite3 *database;
    
    // Init the animals Array
    self.dbItems = [[NSMutableArray alloc] init];
    
    // Open the database from the users filessytem
    if(sqlite3_open([databasePath UTF8String], &database) == SQLITE_OK) {
        // Setup the SQL Statement and compile it for faster access
        const char *sqlStatement = [[NSString stringWithFormat:@"select * from %@", databaseTable] UTF8String];
        sqlite3_stmt *compiledStatement;
        if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK) {
            // Loop through the results and add them to the feeds array
            while(sqlite3_step(compiledStatement) == SQLITE_ROW) {
                // Read the data from the result row
                
                NSMutableDictionary *itemDict = [[NSMutableDictionary alloc] init];
                
                NSString *aType = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 3)];
                NSString *aBrand = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 4)];
                NSString *aModel = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 30)];
                
                NSLog(@"%@", aType);
                NSLog(@"%@", aBrand);
                NSLog(@"%@", aModel);
                
                NSMutableArray *keys = [[NSMutableArray alloc] init];
                
                [keys addObject:[self readDB:compiledStatement Index:5]]; //key0
                [keys addObject:[self readDB:compiledStatement Index:6]]; //key1
                [keys addObject:[self readDB:compiledStatement Index:17]]; //key2
                [keys addObject:[self readDB:compiledStatement Index:23]]; //key3
                [keys addObject:[self readDB:compiledStatement Index:24]]; //key4
                [keys addObject:[self readDB:compiledStatement Index:25]]; //key5
                [keys addObject:[self readDB:compiledStatement Index:26]]; //key6
                [keys addObject:[self readDB:compiledStatement Index:27]]; //key7
                [keys addObject:[self readDB:compiledStatement Index:28]]; //key8
                [keys addObject:[self readDB:compiledStatement Index:29]]; //key9
                
                [keys addObject:[self readDB:compiledStatement Index:7]]; //key0
                [keys addObject:[self readDB:compiledStatement Index:8]]; //key1
                [keys addObject:[self readDB:compiledStatement Index:9]]; //key2
                [keys addObject:[self readDB:compiledStatement Index:10]]; //key3
                [keys addObject:[self readDB:compiledStatement Index:11]]; //key4
                [keys addObject:[self readDB:compiledStatement Index:12]]; //key5
                [keys addObject:[self readDB:compiledStatement Index:13]]; //key6
                [keys addObject:[self readDB:compiledStatement Index:14]]; //key7
                [keys addObject:[self readDB:compiledStatement Index:15]]; //key8
                [keys addObject:[self readDB:compiledStatement Index:16]]; //key9
                
                [keys addObject:[self readDB:compiledStatement Index:18]]; //key0
                [keys addObject:[self readDB:compiledStatement Index:19]]; //key1
                [keys addObject:[self readDB:compiledStatement Index:20]]; //key2
                [keys addObject:[self readDB:compiledStatement Index:21]]; //key3
                [keys addObject:[self readDB:compiledStatement Index:22]]; //key4
                
                [itemDict setObject:aType forKey:@"type"];
                [itemDict setObject:aBrand forKey:@"brand"];
                [itemDict setObject:aModel forKey:@"model"];
                [itemDict setObject:keys forKey:@"keys"];
                
                NSLog(@"itemDict = %@", itemDict);
                
                [self.dbItems addObject:itemDict];
            }
        }
        // Release the compiled statement from memory
        sqlite3_finalize(compiledStatement);
        
    }
    sqlite3_close(database);    
}

- (NSString *) readDB:(sqlite3_stmt *)compiledStatement Index:(int)index{
    NSLog(@"index = %d", index);
    NSString *str = ((char *)sqlite3_column_text(compiledStatement, index)) ? [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, index)] : @"0";
    return str;
}

@end
