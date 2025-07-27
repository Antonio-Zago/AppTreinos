using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace GymSquadBackEnd.Application.Dtos
{
    public class PagedBaseResponseDto<T>
    {
        public PagedBaseResponseDto(int totalRegistros, int totalPaginas, List<T> dados)
        {
            TotalRegistros = totalRegistros;
            Dados = dados;
            TotalPaginas = totalPaginas;
        }

        public int TotalRegistros { get; private set; }

        public int TotalPaginas { get; private set; }

        public List<T> Dados { get; private set; }

        
    }
}
