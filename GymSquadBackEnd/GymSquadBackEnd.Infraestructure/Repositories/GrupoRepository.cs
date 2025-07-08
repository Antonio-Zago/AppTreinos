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

        public Grupo GetByCodigo(int codigo)
        {
            return _appDbContext.Grupos.Where(a => a.Codigo == codigo).FirstOrDefault();
        }

        public void Delete(Grupo grupo)
        {
            _appDbContext.Remove(grupo);
            _appDbContext.SaveChanges();
        }

        public int RetornarMaiorCodigo()
        {
            return _appDbContext.Grupos.Max(g => (int?)g.Codigo) ?? 100;
        }
    }
}
