using GymSquadBackEnd.Domain.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace GymSquadBackEnd.Domain.Interfaces
{
    public interface IUsuarioTreinoRepository
    {
        public IEnumerable<UsuarioTreino> GetAll();

        public UsuarioTreino Post(UsuarioTreino entidade);

        public UsuarioTreino Update(UsuarioTreino entidade);

        public void Delete(UsuarioTreino entidade);

        public IEnumerable<UsuarioTreino> GetByUserId(int userId);

        public UsuarioTreino GetByTreinoId(int treinoId);
    }
}
