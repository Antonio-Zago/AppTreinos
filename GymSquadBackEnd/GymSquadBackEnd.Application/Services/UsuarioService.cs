using GymSquadBackEnd.Application.Dtos;
using GymSquadBackEnd.Application.Helpers;
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
    public class UsuarioService : IUsuarioService
    {
        private readonly IUsuarioRepository _repository;

        public UsuarioService(IUsuarioRepository repository)
        {
            _repository = repository;
        }

        public IEnumerable<UsuarioDto> GetAll()
        {
            var entidades = _repository.GetAll();

            foreach (var entidade in entidades)
            {
                yield return UsuarioMapper.ToDto(entidade);
            }

        }

        public UsuarioDto GetById(int id)
        {
            var entidade = _repository.GetById(id);

            if (entidade == null)
            {
                return null;
            }

            return UsuarioMapper.ToDto(entidade);
        }

        public UsuarioDto Post(RegisterForm form)
        {
            var entidade = UsuarioMapper.ToEntidade(form);

            var entidadeSalva = _repository.Post(entidade);

            return UsuarioMapper.ToDto(entidadeSalva);
        }

        public UsuarioDto? Update(int id, UsuarioForm form)
        {
            var entidadeBanco = _repository.GetById(id);

            if (entidadeBanco == null)
            {
                return null;
            }

            entidadeBanco.Senha = form.Senha;
            entidadeBanco.Email = form.Email;

            var entidadeAtualizada = _repository.Update(entidadeBanco);

            return UsuarioMapper.ToDto(entidadeAtualizada);
        }

        public UsuarioDto? Delete(int id)
        {
            var entidadeBanco = _repository.GetById(id);

            if (entidadeBanco == null)
            {
                return null;
            }

            var entidadeDeletada = _repository.Delete(entidadeBanco);

            return UsuarioMapper.ToDto(entidadeDeletada);

        }

        public UsuarioDto? FindByEmail(string email)
        {
            var usuario = _repository.FindByEmail(email);
            if (usuario != null)
            {
                return UsuarioMapper.ToDto(usuario);
            }

            return null;
        }

        public UsuarioDto? FindByNome(string nome)
        {
            var usuario = _repository.FindByNome(nome);
            if (usuario != null)
            {
                return UsuarioMapper.ToDto(usuario);
            }

            return null;
        }

        public bool CheckPassword(string senhaForm, string senha)
        {
            return senhaForm.GerarHash() == senha;
        }

        public UsuarioDto? UpdateRefreshToken(int id, UsuarioDto dto)
        {
            var entidadeBanco = _repository.GetById(id);

            if (entidadeBanco == null)
            {
                return null;
            }

            entidadeBanco.RefreshToken = dto.RefreshToken;
            entidadeBanco.RefreshTokenExpiryTime = dto.RefreshTokenExpiryTime;

            var entidadeAtualizada = _repository.Update(entidadeBanco);

            return UsuarioMapper.ToDto(entidadeAtualizada);
        }

        
    }
}
