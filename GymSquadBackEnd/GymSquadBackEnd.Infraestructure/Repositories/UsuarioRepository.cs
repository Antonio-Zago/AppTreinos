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
    public class UsuarioRepository : IUsuarioRepository
    {
        private readonly AppDbContext _appDbContext;

        public UsuarioRepository(AppDbContext appDbContext)
        {
            _appDbContext = appDbContext;
        }

        public IEnumerable<Usuario> GetAll()
        {
            return _appDbContext.Usuarios;
        }

        public Usuario GetById(int id)
        {
            return _appDbContext.Usuarios.Where(x => x.Id == id).FirstOrDefault();
        }

        public IEnumerable<Usuario> GetByIds(IEnumerable<int> ids)
        {
            return _appDbContext.Usuarios.Where(x => ids.Contains(x.Id));
        }

        public Usuario Post(Usuario entidade)
        {
            _appDbContext.Usuarios.Add(entidade);
            _appDbContext.SaveChanges();
            return entidade;
        }

        public Usuario Update(Usuario entidade)
        {
            _appDbContext.Entry(entidade).State = EntityState.Modified;
            _appDbContext.SaveChanges();

            return entidade;
        }

        public Usuario Delete(Usuario entidade)
        {
            _appDbContext.Remove(entidade);
            _appDbContext.SaveChanges();

            return entidade;
        }

        public Usuario? FindByEmail(string email)
        {
            return _appDbContext.Usuarios.Where(a => a.Email == email).FirstOrDefault();
        }

        public Usuario? FindByNome(string nome)
        {
            return _appDbContext.Usuarios.Where(a => a.NomeUsuario == nome).FirstOrDefault();
        }

       
    }
}
