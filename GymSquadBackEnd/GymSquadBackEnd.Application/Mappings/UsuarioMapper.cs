using GymSquadBackEnd.Application.Dtos;
using GymSquadBackEnd.Application.Helpers;
using GymSquadBackEnd.Domain.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace GymSquadBackEnd.Application.Mappings
{
    public static class UsuarioMapper
    {
        public static UsuarioDto ToDto(Usuario entidade)
        {
            return new UsuarioDto
            {
                Id = entidade.Id,
                Nome = entidade.NomeUsuario,
                Email = entidade.Email,
                Senha = entidade.Senha,
                RefreshToken = entidade.RefreshToken,
                RefreshTokenExpiryTime = entidade.RefreshTokenExpiryTime,
                Foto = entidade.Foto,
            };
        }

        public static Usuario ToEntidade(RegisterForm form)
        {
            return new Usuario
            {
                Email = form.Email,
                Senha = form.Senha.GerarHash(),
                NomeUsuario = form.Nome,
                Foto = form.Foto
            };
        }
    }
}
