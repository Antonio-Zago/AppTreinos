using GymSquadBackEnd.Application.Dtos;
using GymSquadBackEnd.Domain.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace GymSquadBackEnd.Application.Mappings
{
    public static class UsuarioTreinoMapper
    {
        public static UsuarioTreinoDto ToDto(UsuarioTreino entidade)
        {
            return new UsuarioTreinoDto
            {
                NomeTreino = entidade.Treino.Nome,
                TreinoId = entidade.TreinoId,
                UsuarioId = entidade.UsuarioId,
            };
        }

        
    }
}
