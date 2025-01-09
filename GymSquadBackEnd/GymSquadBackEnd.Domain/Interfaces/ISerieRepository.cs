using GymSquadBackEnd.Domain.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace GymSquadBackEnd.Domain.Interfaces
{
    public interface ISerieRepository
    {
        public Serie Post(Serie serie);

        public Serie GetById(int id);

        public Serie Update(Serie serie);

        public List<Serie> GetByTreinoExercicioId(int treinoExercicioId);

        public Serie Delete(Serie serie);

        public Serie DeleteById(int idserie);
    }
}
