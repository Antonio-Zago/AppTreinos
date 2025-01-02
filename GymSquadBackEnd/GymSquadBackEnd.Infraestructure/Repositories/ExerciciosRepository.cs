using GymSquadBackEnd.Domain.Entities;
using GymSquadBackEnd.Domain.Interfaces;
using GymSquadBackEnd.Infraestructure.Context;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace GymSquadBackEnd.Infraestructure.Repositories
{
    public class ExerciciosRepository : IExerciciosRepository
    {
        public AppDbContext _appDbContext;

        public ExerciciosRepository(AppDbContext appDbContext)
        {
            _appDbContext = appDbContext;
        }

        public List<Exercicio> GetAll()
        {
            return _appDbContext.Exercicios.ToList();
        }

        public void Post(Exercicio exercicio)
        {
            _appDbContext.Exercicios.Add(exercicio);
            _appDbContext.SaveChanges();
        }
    }
}
