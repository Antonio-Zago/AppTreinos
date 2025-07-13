using GymSquadBackEnd.Domain.Entities;
using GymSquadBackEnd.Domain.Interfaces;
using Microsoft.Extensions.Configuration;
using MySql.Data.MySqlClient;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace GymSquadBackEnd.Infraestructure.Repositories
{
    public class QueryRepository : IQueryRepository
    {
        private readonly string _connectionString;

        public QueryRepository(IConfiguration configuration)
        {
            _connectionString = configuration.GetConnectionString("DefaultConnection");
        }

        public List<Dictionary<string, QueryResult>> Execute(string query, MySqlParameter[] parametros )
        {
            var resultado = new List<Dictionary<string, QueryResult>>();

            using (var connection = new MySqlConnection(_connectionString))
            using (var command = new MySqlCommand(query, connection))
            {
                foreach (var parametro in parametros) 
                {
                    command.Parameters.Add(parametro);
                }

                connection.Open();
                using (var reader = command.ExecuteReader())
                {
                    var numeroColunas = reader.FieldCount;
                    while (reader.Read())
                    {
                        var dicionario = new Dictionary<string, QueryResult>();
                        for (var colunaIndex = 0;colunaIndex< numeroColunas;colunaIndex++)
                        {
                            var nomeColuna = reader.GetName(colunaIndex);
                            dicionario.Add(nomeColuna, new QueryResult()
                            {
                                Campo = reader[nomeColuna]
                            });
                        }

                        resultado.Add(dicionario);
                    }
                }
            }

            return resultado;
        }
    }
}
