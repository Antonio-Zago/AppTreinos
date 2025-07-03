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
        IEnumerable<UsuarioGrupoDto> GetByUserId(int userId);

        UsuarioGrupoDto Post(UsuarioGrupoForm form);

        void DeleteByGrupoIdAndUserId(int grupoId, int userId);

        IEnumerable<UsuarioGrupoDto> GetByGrupoId(int grupoId);
    }
}
