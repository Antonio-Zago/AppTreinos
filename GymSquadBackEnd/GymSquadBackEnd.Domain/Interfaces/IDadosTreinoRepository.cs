using GymSquadBackEnd.Domain.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace GymSquadBackEnd.Domain.Interfaces
{
    public interface IDadosTreinoRepository
    {
        public DadosTreino Post(DadosTreino entidade);
    }
}
