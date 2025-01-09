using GymSquadBackEnd.Domain.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace GymSquadBackEnd.Domain.Interfaces
{
    public interface ITreinoExercicioRepository
    {

        public IEnumerable<TreinoExercicio> GetAll();

        public TreinoExercicio Post(TreinoExercicio entidade);

        public TreinoExercicio Update(TreinoExercicio entidade);

        public TreinoExercicio Delete(TreinoExercicio entidade);

        public IEnumerable<TreinoExercicio> GetByTreinoId(int treinoId);

        public TreinoExercicio GetByTreinoIdAndExercicioId(int treinoId, int exercicioId);

        public TreinoExercicio DeleteByExercicioIdAndTreinoId(int exercicioId, int treinoId);
    }
}
