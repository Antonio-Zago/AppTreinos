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

        public UsuarioGrupoService(IUsuarioGrupoRepository usuarioGrupoRepository, IGrupoRepository grupoRepository)
        {
            _usuarioGrupoRepository = usuarioGrupoRepository;
            _grupoRepository = grupoRepository;
        }

        public UsuarioGrupoDto Post(UsuarioGrupoForm form)
        {
            var entidade = new UsuarioGrupo();

            var grupo = new Grupo();

            grupo.Nome = form.Nome;

            entidade.Grupo = grupo;
            entidade.UsuarioId = form.UsuarioId;
            entidade.EhAdmin = true;

            var entidadeSalva = _usuarioGrupoRepository.Post(entidade);

            return UsuarioGrupoMapper.ToDto(entidadeSalva); ;
        }

        public IEnumerable<UsuarioGrupoDto> GetByUserId(int userId)
        {
            var entidades = _usuarioGrupoRepository.GetByUserId(userId);

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

            if (!usuarioGrupo.EhAdmin)
            {
                throw new Exception($"Usuário não é admin");
            }

            var grupo = _grupoRepository.GetById(grupoId);

            if (grupo == null)
            {
                throw new Exception($"Não encontrado grupo com id {grupoId}");
            }

            //Falta excluir o grupo

            var usuariosGrupo = _usuarioGrupoRepository.GetByGroupId(grupoId);


            _usuarioGrupoRepository.DeleteRange(usuariosGrupo.ToList());

            _grupoRepository.Delete(grupo);

        }
    }
}
