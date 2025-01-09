using GymSquadBackEnd.Domain.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace GymSquadBackEnd.Domain.Interfaces
{
    public interface ITreinoRepository
    {
        public Treino Post(Treino entidade);

        public Treino GetById(int id);

        public Treino Update(Treino treino);
    }
}
