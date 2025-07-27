using GymSquadBackEnd.Application.Dtos;
using GymSquadBackEnd.Domain.Requests;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace GymSquadBackEnd.Application.Interfaces
{
    public interface IPublicacaoService
    {
        PublicacaoDto Post(PublicacaoForm form);

        PagedBaseResponseDto<PublicacaoDto> GetByCodigoGrupoPaged(int codigo, PagedBaseRequests request);
    }
}
