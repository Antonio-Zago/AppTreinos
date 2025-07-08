using GymSquadBackEnd.Domain.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace GymSquadBackEnd.Domain.Interfaces
{
    public interface IGrupoRepository
    {
        Grupo GetById(int grupoId);
        void Delete(Grupo grupo);

        Grupo GetByCodigo(int codigo);

        int RetornarMaiorCodigo();

    }
}
