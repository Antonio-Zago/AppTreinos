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
    public class UsuarioTreinoRepository : IUsuarioTreinoRepository
    {
        private readonly AppDbContext _appDbContext;

        public UsuarioTreinoRepository(AppDbContext appDbContext)
        {
            _appDbContext = appDbContext;
        }

        public IEnumerable<UsuarioTreino> GetAll()
        {
            return _appDbContext.Usuarios_Treinos.Include(a => a.Treino);
        }

        public IEnumerable<UsuarioTreino> GetByUserId(int userId)
        {
            return _appDbContext.Usuarios_Treinos.Include(a => a.Treino).Where(a => a.UsuarioId == userId);
        }

        public UsuarioTreino Post(UsuarioTreino entidade)
        {
            _appDbContext.Usuarios_Treinos.Add(entidade);
            _appDbContext.SaveChanges();
            return entidade;
        }

        public UsuarioTreino Update(UsuarioTreino entidade)
        {
            _appDbContext.Entry(entidade).State = EntityState.Modified;
            _appDbContext.SaveChanges();

            return entidade;
        }

        public UsuarioTreino Delete(UsuarioTreino entidade)
        {
            _appDbContext.Remove(entidade);
            _appDbContext.SaveChanges();

            return entidade;
        }
    }
}
