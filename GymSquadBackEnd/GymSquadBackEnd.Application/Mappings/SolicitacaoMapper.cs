using GymSquadBackEnd.Application.Dtos;
using GymSquadBackEnd.Domain.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace GymSquadBackEnd.Application.Mappings
{
    public static class SolicitacaoMapper
    {
        public static SolicitacaoDto ToDto(Solicitacoes entidade)
        {
            return new SolicitacaoDto
            {
                UsuarioId = entidade.UsuarioId,
                UsuarioNome = entidade.Usuario.NomeUsuario,
                DataHora = entidade.DataHora,
                GrupoId = entidade.GrupoId,
                Status = entidade.Status
            };
        }

    }
}
