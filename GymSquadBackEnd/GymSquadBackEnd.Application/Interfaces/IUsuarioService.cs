using GymSquadBackEnd.Application.Dtos;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace GymSquadBackEnd.Application.Interfaces
{
    public interface IUsuarioService
    {
        IEnumerable<UsuarioDto> GetAll();

        UsuarioDto GetById(int id);

        UsuarioDto Post(RegisterForm form);

        UsuarioDto? Update(int id, UsuarioForm form);

        UsuarioDto? Delete(int id);

        UsuarioDto? FindByEmail(string email);

        bool CheckPassword(string senhaForm, string senha);
        UsuarioDto? UpdateRefreshToken(int id, UsuarioDto dto);

        UsuarioDto? FindByNome(string nome);

    }
}
