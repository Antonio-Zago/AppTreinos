using GymSquadBackEnd.Application.Dtos;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace GymSquadBackEnd.Application.Interfaces
{
    public interface IUsuarioTreinoService
    {
        public List<UsuarioTreinoDto> getByUserId(int userId);

        public UsuarioTreinoDto Post(UsuarioTreinoForm form);

        public void Delete(int treinoId);
    }
}
