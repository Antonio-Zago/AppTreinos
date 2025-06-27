using GymSquadBackEnd.Application.Dtos;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace GymSquadBackEnd.Application.Interfaces
{
    public interface IUsuarioGrupoService
    {
        public IEnumerable<UsuarioGrupoDto> GetByUserId(int userId);

        public UsuarioGrupoDto Post(UsuarioGrupoForm form);

        public void DeleteByGrupoIdAndUserId(int grupoId, int userId);
    }
}
