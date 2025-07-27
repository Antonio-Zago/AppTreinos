using GymSquadBackEnd.Domain.Entities;
using GymSquadBackEnd.Domain.Requests;
using GymSquadBackEnd.Domain.Responses;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace GymSquadBackEnd.Domain.Interfaces
{
    public interface IPublicacaoRepository
    {
        Publicacao Post(Publicacao entidade);

        PagedBaseResponse<Publicacao> GetByCodigoGrupoPaged(int codigoGrupo, PagedBaseRequests request);
    }
}
