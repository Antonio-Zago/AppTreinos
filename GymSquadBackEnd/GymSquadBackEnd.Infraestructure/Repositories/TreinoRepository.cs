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
    public class TreinoRepository : ITreinoRepository
    {
        private readonly AppDbContext _appDbContext;

        public TreinoRepository(AppDbContext appDbContext)
        {
            _appDbContext = appDbContext;
        }

        public Treino Post(Treino entidade)
        {
            _appDbContext.Treinos.Add(entidade);
            _appDbContext.SaveChanges();
            return entidade;
        }

        public Treino GetById(int id)
        {
            return _appDbContext.Treinos.Where(a => a.Id == id).FirstOrDefault();
        }

        public Treino Update(Treino treino)
        {
            _appDbContext.Entry(treino).State = EntityState.Modified;
            _appDbContext.SaveChanges();

            return treino;
        }

    }
}
