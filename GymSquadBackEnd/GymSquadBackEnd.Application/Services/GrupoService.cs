using GymSquadBackEnd.Application.Dtos;
using GymSquadBackEnd.Application.Interfaces;
using GymSquadBackEnd.Application.Mappings;
using GymSquadBackEnd.Domain.Interfaces;
using MySql.Data.MySqlClient;
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

        private readonly IQueryRepository _queryRepository;

        public GrupoService(IGrupoRepository repositoryGrupo, IQueryRepository queryRepository)
        {
            _repositoryGrupo = repositoryGrupo;
            _queryRepository = queryRepository;
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

        public List<GrupoRankingDto> GetRankingGrupoByCodigo(int codigo, DateTime inicio, DateTime fim)
        {
            var dtos = new List<GrupoRankingDto>();

            var entidade = _repositoryGrupo.GetByCodigo(codigo);

            if (entidade == null)
            {
                throw new Exception($"Grupo não encontrado com o código {codigo}");
            }

            var retorno = _queryRepository.Execute(@"SELECT c.NomeUsuario, count(d.Id) Quantidade 
                                                   FROM grupos a 
                                                   INNER JOIN usuarios_grupos b ON a.Id = b. Grupo
                                                   INNER JOIN Usuarios c ON b.Usuario = c.Id 
                                                   LEFT JOIN dados_treino d ON c.Id = d.Usuario
                                                        AND d.DataAtual >= @inicio
                                                        AND d.DataAtual <= @fim
                                                   WHERE a.Codigo = @codigoGrupo
                                                   GROUP BY c.NomeUsuario", 
                                                   [new MySqlParameter("codigoGrupo", codigo),
                                                    new MySqlParameter("inicio", inicio),
                                                    new MySqlParameter("fim", fim)]);

            foreach (var ranking in retorno)
            {
                var dto = new GrupoRankingDto();

                dto.NomeUsuario = ranking["NomeUsuario"].getString();
                dto.Quantidade = ranking["Quantidade"].getLong();

                dtos.Add(dto);
            }

            return dtos;
        }
    }
}
