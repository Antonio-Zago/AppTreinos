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
    public class UsuarioGrupoRepository : IUsuarioGrupoRepository
    {
        private readonly AppDbContext _appDbContext;

        public UsuarioGrupoRepository(AppDbContext appDbContext)
        {
            _appDbContext = appDbContext;
        }

        public void Delete(UsuarioGrupo entidade)
        {
            _appDbContext.Remove(entidade);
            _appDbContext.SaveChanges();
        }

        public void DeleteRange(List<UsuarioGrupo> entidades)
        {
            _appDbContext.RemoveRange(entidades);
            _appDbContext.SaveChanges();
        }

        public IEnumerable<UsuarioGrupo> GetByGroupId(int groupId)
        {
            return _appDbContext.Usuarios_Grupos.Where(a => a.GrupoId == groupId).Include(a => a.Grupo).Include(a => a.Usuario);
        }

        public IEnumerable<UsuarioGrupo> GetByUserId(int userId)
        {
            return _appDbContext.Usuarios_Grupos.Where(a => a.UsuarioId == userId).Include(a => a.Grupo);
        }
        public UsuarioGrupo GetByUserIdAndGroupId(int userId, int groupId)
        {
            return _appDbContext.Usuarios_Grupos.Where(a => a.UsuarioId == userId && a.GrupoId == groupId).Include(a => a.Grupo).FirstOrDefault();
        }

        public UsuarioGrupo Post(UsuarioGrupo entidade)
        {
            _appDbContext.Usuarios_Grupos.Add(entidade);
            _appDbContext.SaveChanges();

            return entidade;
        }

        public UsuarioGrupo Update(UsuarioGrupo entidade)
        {
            _appDbContext.Entry(entidade).State = EntityState.Modified;
            _appDbContext.SaveChanges();

            return entidade;
        }
    }
}
