using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace GymSquadBackEnd.Domain.Entities
{
    public class QueryResult
    {
        private object _campo;
        public object Campo
        {
            set { _campo = value; }
        }

        public long getLong()
        {
            return (long) _campo;
        }

        public string getString()
        {
            return _campo.ToString();
        }
    }
}
