using GymSquadBackEnd.Domain.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace GymSquadBackEnd.Domain.Interfaces
{
    public interface IUsuarioRepository
    {
        IEnumerable<Usuario> GetAll();

        Usuario GetById(int id);

        Usuario Post(Usuario entidade);

        Usuario Update(Usuario entidade);

        Usuario Delete(Usuario entidade);

        Usuario? FindByEmail(string email);

        Usuario? FindByNome(string nome);
    }
}
