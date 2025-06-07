const String DATABASE_NAME = 'gym_squad_db';

const String TREINOS_TABLE_NAME = 'treinos';
const String TREINOS_COLUMN_ID = 'Id';
const String TREINOS_COLUMN_NOME = 'Nome';

const String CREATE_TREINOS_TABLE_SCRIPT = '''
  CREATE TABLE $TREINOS_TABLE_NAME
  (
    $TREINOS_COLUMN_ID INTEGER PRIMARY KEY,
    $TREINOS_COLUMN_NOME TEXT
  )
  ''';