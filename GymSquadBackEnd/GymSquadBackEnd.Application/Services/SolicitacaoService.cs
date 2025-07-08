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

        private readonly IUsuarioGrupoRepository _repositoryUsuarioGrupo;

        private readonly IUnitOfWork _unitOfwork;

        public SolicitacaoService(ISolicitacaoRepository repository, IGrupoRepository repositoryGrupo, IUsuarioRepository repositoryUsuario, IUsuarioGrupoRepository repositoryUsuarioGrupo, IUnitOfWork unitOfwork)
        {
            _repository = repository;
            _repositoryGrupo = repositoryGrupo;
            _repositoryUsuario = repositoryUsuario;
            _repositoryUsuarioGrupo = repositoryUsuarioGrupo;
            _unitOfwork = unitOfwork;
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

            var grupo = _repositoryGrupo.GetByCodigo(form.CodigoGrupo);

            if (grupo == null)
            {
                throw new Exception("Grupo não encontrado");
            }

            var grupoUsuario = _repositoryUsuarioGrupo.GetByUserIdAndGroupId(form.UsuarioId, grupo.Id);

            if (grupoUsuario != null)
            {
                throw new Exception("Usuário já existe no grupo");
            }

            var solicitacao = _repository.GetByGroupIdAndUserId(grupo.Id, form.UsuarioId);

            if (solicitacao != null)
            {
                throw new Exception("solicitação já cadastrada");
            }

            var usuario = _repositoryUsuario.GetById(form.UsuarioId);

            if (usuario == null)
            {
                throw new Exception("Usuário não encontrado");
            }

            SolicitacaoDto dto = new SolicitacaoDto();

            try
            {
                _unitOfwork.BeginTransaction();

                solicitacao = new Solicitacoes();
                solicitacao.GrupoId = grupo.Id;
                solicitacao.Usuario = usuario;
                solicitacao.DataHora = DateTime.Now;
                solicitacao.Status = 1;

                _repository.Post(solicitacao);

                dto = SolicitacaoMapper.ToDto(solicitacao);

                _unitOfwork.Commit();
            }
            catch
            {
                _unitOfwork.Roolback();
            }
            return dto;
            
        }

        public SolicitacaoDto AceitarSolicitacao(SolicitacaoForm form)
        {
            var grupo = _repositoryGrupo.GetByCodigo(form.CodigoGrupo);

            if (grupo == null)
            {
                throw new Exception("Grupo não encontrado");
            }

            var solicitacao = _repository.GetByGroupIdAndUserId(grupo.Id, form.UsuarioId);

            if (solicitacao == null)
            {
                throw new Exception("Não encontrado solicitação do usuário para o grupo");
            }

            solicitacao.Status = 2;

            var usuarioGrupo = new UsuarioGrupo()
            {
                UsuarioId = form.UsuarioId,
                GrupoId = grupo.Id,
                EhAdmin = false
            };

            _repositoryUsuarioGrupo.Post(usuarioGrupo);

            var solicitacaoSalva = _repository.Update(solicitacao);

            return SolicitacaoMapper.ToDto(solicitacaoSalva);
        }

        public SolicitacaoDto RecusarSolicitacao(SolicitacaoForm form)
        {
            var grupo = _repositoryGrupo.GetByCodigo(form.CodigoGrupo);

            if (grupo == null)
            {
                throw new Exception("Grupo não encontrado");
            }

            var solicitacao = _repository.GetByGroupIdAndUserId(grupo.Id, form.UsuarioId);

            if (solicitacao == null)
            {
                throw new Exception("Não encontrado solicitação do usuário para o grupo");
            }

            solicitacao.Status = 3;

            var solicitacaoSalva = _repository.Update(solicitacao);

            return SolicitacaoMapper.ToDto(solicitacaoSalva);
        }


    }
}
