using GymSquadBackEnd.Application.Dtos;
using GymSquadBackEnd.Application.Interfaces;
using GymSquadBackEnd.Application.Mappings;
using GymSquadBackEnd.Domain.Interfaces;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace GymSquadBackEnd.Application.Services
{
    public class GrupoService : IGrupoService
    {

        private readonly IGrupoRepository _repositoryGrupo;

        public GrupoService(IGrupoRepository repositoryGrupo)
        {
            _repositoryGrupo = repositoryGrupo;
        }

        public GrupoDto GetByCodigo(int codigo)
        {
            var entidade = _repositoryGrupo.GetByCodigo(codigo);

            if (entidade == null)
            {
                throw new Exception($"Grupo não encontrado com o código {codigo}");
            }

            var dto = new GrupoDto()
            {
                Codigo = entidade.Codigo,
                Nome = entidade.Nome
            };

            return dto;
        }
    }
}
