using GymSquadBackEnd.Domain.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace GymSquadBackEnd.Domain.Interfaces
{
    public interface IUsuarioGrupoRepository
    {
        public UsuarioGrupo Post(UsuarioGrupo entidade);

        public UsuarioGrupo Update(UsuarioGrupo entidade);

        public void Delete(UsuarioGrupo entidade);

        public void DeleteRange(List<UsuarioGrupo> entidades);

        public IEnumerable<UsuarioGrupo> GetByUserId(int userId);
        public IEnumerable<UsuarioGrupo> GetByGroupId(int groupId);

        public UsuarioGrupo GetByUserIdAndGroupId(int userId, int groupId);

    }
}
