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
    public class SerieRepository : ISerieRepository
    {
        public AppDbContext _appDbContext;

        public SerieRepository(AppDbContext appDbContext)
        {
            _appDbContext = appDbContext;
        }

        public Serie Post(Serie serie)
        {
            _appDbContext.Series.Add(serie);
            _appDbContext.SaveChanges();
            return serie;
        }

        public Serie Update(Serie serie)
        {
            _appDbContext.Entry(serie).State = EntityState.Modified;
            _appDbContext.SaveChanges();

            return serie;
        }

        public Serie GetById(int id) 
        {
            return _appDbContext.Series.Where(a => a.Id == id).FirstOrDefault();
        }

        public List<Serie> GetByTreinoExercicioId(int treinoExercicioId)
        {
            return _appDbContext.Series.Where(a => a.TreinoExercicioId == treinoExercicioId).ToList();
        }
            
        public Serie Delete(Serie serie)
        {
            _appDbContext.Remove(serie);
            _appDbContext.SaveChanges();

            return serie;
        }

        public Serie DeleteById(int idserie)
        {
            var serie = GetById(idserie);

            Delete(serie);

            return serie;
        }

    }
}
