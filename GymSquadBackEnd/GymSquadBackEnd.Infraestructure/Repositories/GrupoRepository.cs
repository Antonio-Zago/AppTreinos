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
    public class GrupoRepository : IGrupoRepository
    {

        private readonly AppDbContext _appDbContext;

        public GrupoRepository(AppDbContext appDbContext)
        {
            _appDbContext = appDbContext;
        }

        public Grupo GetById(int grupoId)
        {
            return _appDbContext.Grupos.Where(a => a.Id == grupoId).FirstOrDefault() ;
        }

        public void Delete(Grupo grupo)
        {
            _appDbContext.Remove(grupo);
            _appDbContext.SaveChanges();
        }
    }
}
