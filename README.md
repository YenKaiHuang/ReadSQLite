ReadSQLite
==========
1. Add Framework: libsqlite3.0.dylib
2. SQLiteRead *sqlRead = [[SQLiteRead alloc] initWithDBName:@"IRDB.sqlite" tableName:@"ZIRCODETABLE"];
3. [sqlRead checkAndCreateDatabase];
4. [sqlRead readDatabase];
5. NSLog(@"dbItems = %@", sqlRead.dbItems);
