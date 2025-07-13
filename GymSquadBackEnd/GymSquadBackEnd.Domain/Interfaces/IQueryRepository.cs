using GymSquadBackEnd.Domain.Entities;
using MySql.Data.MySqlClient;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace GymSquadBackEnd.Domain.Interfaces
{
    public interface IQueryRepository
    {
        List<Dictionary<string, QueryResult>> Execute(string query, MySqlParameter[] parametros);
    }
}
