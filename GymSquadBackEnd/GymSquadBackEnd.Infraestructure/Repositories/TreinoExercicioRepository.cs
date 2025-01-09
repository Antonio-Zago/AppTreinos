using GymSquadBackEnd.Domain.Entities;
using GymSquadBackEnd.Domain.Interfaces;
using GymSquadBackEnd.Infraestructure.Context;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace GymSquadBackEnd.Infraestructure.Repositories
{
    public class TreinoExercicioRepository : ITreinoExercicioRepository
    {
        private readonly AppDbContext _appDbContext;

        public TreinoExercicioRepository(AppDbContext appDbContext)
        {
            _appDbContext = appDbContext;
        }

        public IEnumerable<TreinoExercicio> GetAll()
        {
            return _appDbContext.Treinos_Exercicios.Include(a => a.Exercicio);
        }

        public IEnumerable<TreinoExercicio> GetByTreinoId(int treinoId)
        {
            return _appDbContext.Treinos_Exercicios.Include(a => a.Exercicio).Where(a => a.TreinoId == treinoId).ToList();
        }

        public TreinoExercicio GetByTreinoIdAndExercicioId(int treinoId, int exercicioId)
        {
            return _appDbContext.Treinos_Exercicios.Include(a => a.Exercicio).Where(a => a.TreinoId == treinoId && a.ExercicioId == exercicioId).FirstOrDefault();
        }

        public TreinoExercicio Post(TreinoExercicio entidade)
        {
            _appDbContext.Treinos_Exercicios.Add(entidade);
            _appDbContext.SaveChanges();
            return entidade;
        }

        public TreinoExercicio Update(TreinoExercicio entidade)
        {
            _appDbContext.Entry(entidade).State = EntityState.Modified;
            _appDbContext.SaveChanges();

            return entidade;
        }

        public TreinoExercicio Delete(TreinoExercicio entidade)
        {
            _appDbContext.Remove(entidade);
            _appDbContext.SaveChanges();

            return entidade;
        }

        public TreinoExercicio DeleteByExercicioIdAndTreinoId(int exercicioId, int treinoId)
        {
            var entidade = GetByTreinoIdAndExercicioId(treinoId, exercicioId);

            Delete(entidade);

            return entidade;
        }
        
    }
}
