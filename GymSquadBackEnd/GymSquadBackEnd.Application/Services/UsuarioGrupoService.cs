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
    public class UsuarioGrupoService : IUsuarioGrupoService
    {
        private readonly IUsuarioGrupoRepository _usuarioGrupoRepository;

        private readonly IGrupoRepository _grupoRepository;

        private readonly IUnitOfWork    _unitOfWork;

        public UsuarioGrupoService(IUsuarioGrupoRepository usuarioGrupoRepository, IGrupoRepository grupoRepository, IUnitOfWork unitOfWork)
        {
            _usuarioGrupoRepository = usuarioGrupoRepository;
            _grupoRepository = grupoRepository;
            _unitOfWork = unitOfWork;
        }

        public UsuarioGrupoDto Post(UsuarioGrupoForm form)
        {
            Random random = new Random();

            var entidade = new UsuarioGrupo();

            var grupo = new Grupo();

            UsuarioGrupoDto dto = new UsuarioGrupoDto();

            try
            {
                _unitOfWork.BeginTransaction();

                grupo.Nome = form.Nome;

                int codigo = _grupoRepository.RetornarMaiorCodigo() + 1;

                grupo.Codigo = codigo;

                entidade.Grupo = grupo;
                entidade.UsuarioId = form.UsuarioId;
                entidade.EhAdmin = true;

                var entidadeSalva = _usuarioGrupoRepository.Post(entidade);

                dto = UsuarioGrupoMapper.ToDto(entidadeSalva);

                _unitOfWork.Commit();
            }
            catch
            {
                _unitOfWork.Roolback();
                throw new Exception("Ocorreu um erro na requisição");
            }

            return dto;
            
        }

        public IEnumerable<UsuarioGrupoDto> GetByUserId(int userId)
        {
            var entidades = _usuarioGrupoRepository.GetByUserId(userId);

            foreach (var entidade in entidades)
            {
                yield return UsuarioGrupoMapper.ToDto(entidade);
            }
        }

        public IEnumerable<UsuarioGrupoDto> GetByGrupoId(int grupoId)
        {
            var entidades = _usuarioGrupoRepository.GetByGroupId(grupoId);

            foreach (var entidade in entidades)
            {
                yield return UsuarioGrupoMapper.ToDto(entidade);
            }
        }

        public void DeleteByGrupoIdAndUserId(int grupoId, int userId)
        {
            var usuarioGrupo = _usuarioGrupoRepository.GetByUserIdAndGroupId(userId, grupoId);

            if (usuarioGrupo == null)
            {
                throw new Exception($"Não encontrado ligação do grupo com o usuário");
            }

            _usuarioGrupoRepository.Delete(usuarioGrupo);


        }
    }
}
