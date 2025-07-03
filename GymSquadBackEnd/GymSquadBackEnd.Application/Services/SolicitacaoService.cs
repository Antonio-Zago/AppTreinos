using GymSquadBackEnd.Application.Dtos;
using GymSquadBackEnd.Application.Interfaces;
using GymSquadBackEnd.Application.Mappings;
using GymSquadBackEnd.Domain.Entities;
using GymSquadBackEnd.Domain.Interfaces;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace GymSquadBackEnd.Application.Services
{
    public class SolicitacaoService : ISolicitacaoService
    {
        private readonly ISolicitacaoRepository _repository;

        private readonly IGrupoRepository _repositoryGrupo;

        private readonly IUsuarioRepository _repositoryUsuario;

        public SolicitacaoService(ISolicitacaoRepository repository, IGrupoRepository repositoryGrupo, IUsuarioRepository repositoryUsuario)
        {
            _repository = repository;
            _repositoryGrupo = repositoryGrupo;
            _repositoryUsuario = repositoryUsuario;
        }

        public IEnumerable<SolicitacaoDto> GetByGrupoId(int grupoId)
        {
            var entidades = _repository.GetByGroupId(grupoId);

            foreach (var entidade in entidades)
            {
                yield return SolicitacaoMapper.ToDto(entidade);
            }
        }

        public SolicitacaoDto Post(SolicitacaoForm form)
        {
            var usuario = _repositoryUsuario.GetById(form.UsuarioId);

            var solicitacao = new Solicitacoes();
            solicitacao.GrupoId = form.GrupoId;
            solicitacao.Usuario = usuario;
            solicitacao.DataHora = DateTime.Now;
            solicitacao.Status = 1;

            _repository.Post(solicitacao);

            return SolicitacaoMapper.ToDto(solicitacao);
        }
    }
}
