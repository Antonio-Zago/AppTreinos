using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace GymSquadBackEnd.Domain.Responses
{
    public class PagedBaseResponse<T>
    {
        public List<T> Data { get; set; }

        public int TotalPages { get; set; }

        public int TotalRegisters { get; set; }
    }
}
