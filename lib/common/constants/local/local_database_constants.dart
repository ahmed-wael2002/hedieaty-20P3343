String databaseName = 'hedeiaty_database.db';

List<String> databaseCreateCommands = [
    '''
    CREATE TABLE IF NOT EXISTS events (
      id TEXT PRIMARY KEY NOT NULL,
      title TEXT NOT NULL,
      description TEXT,
      date TEXT,
      location TEXT,
      category TEXT,
      userId TEXT NOT NULL
    )
    ''',
      '''
    CREATE TABLE IF NOT EXISTS gifts (
      id TEXT PRIMARY KEY NOT NULL,
      imageUrl TEXT,
      name TEXT NOT NULL,
      description TEXT,
      category TEXT,
      price TEXT,
      isPledged TEXT NOT NULL,
      eventId TEXT NOT NULL,
      userId TEXT NOT NULL
    )
    '''
];
