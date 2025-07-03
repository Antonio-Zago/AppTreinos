using GymSquadBackEnd.Application.Dtos;
using GymSquadBackEnd.Domain.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace GymSquadBackEnd.Application.Mappings
{
    public static class UsuarioGrupoMapper
    {
        public static UsuarioGrupoDto ToDto(UsuarioGrupo entidade)
        {
            return new UsuarioGrupoDto
            {
                Nome = entidade.Grupo!= null ? entidade.Grupo.Nome : null,
                GrupoId = entidade.GrupoId,
                UsuarioId = entidade.UsuarioId,
                EhAdmin = entidade.EhAdmin,
                NomeUsuario = entidade.Usuario != null ? entidade.Usuario.NomeUsuario : null
            };
        }

        public static UsuarioGrupo ToEntidade(UsuarioGrupoForm form)
        {
            return new UsuarioGrupo
            {
                EhAdmin = true,

            };
        }
    }
}
