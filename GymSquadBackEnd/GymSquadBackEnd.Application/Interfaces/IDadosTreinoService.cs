using GymSquadBackEnd.Application.Dtos;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace GymSquadBackEnd.Application.Interfaces
{
    public interface IDadosTreinoService
    {
        public DadosTreinoDto Post(DadosTreinoForm form);
    }
}
