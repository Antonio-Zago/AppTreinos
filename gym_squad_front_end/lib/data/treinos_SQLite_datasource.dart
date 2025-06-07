
import 'package:gym_squad_front_end/data/data_general_constants.dart';
import 'package:gym_squad_front_end/data/data_treinos_constants.dart';
import 'package:gym_squad_front_end/domain/entities/treino_entity.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class TreinosSqliteDatasource {
  Future<Database> getDatabase() async{
    return openDatabase(
      join(await getDatabasesPath(), DATABASE_NAME),
      onCreate: (db, version) async{
        await db.execute(CREATE_TREINOS_TABLE_SCRIPT);
      },
      version: DATABASE_VERSION
    );
  }

  Future create(TreinoEntity treino) async{
      try{
        final Database db =  await getDatabase();

        treino.id = 
          await db.rawInsert(''' INSERT INTO $TREINOS_TABLE_NAME (
            $TREINOS_COLUMN_NOME
          )
          VALUES (
            ${treino.nome}
          )
          ''');

      }
      catch(e){

      }
  }
}