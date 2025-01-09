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

        public Exercicio GetById(int id)
        {
            return _appDbContext.Exercicios.Where(a => a.Id == id).FirstOrDefault();
        }

        public Exercicio Update(Exercicio exercicio)
        {
            _appDbContext.Entry(exercicio).State = EntityState.Modified;
            _appDbContext.SaveChanges();

            return exercicio;
        }
    }
}
