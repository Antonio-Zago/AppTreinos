using GymSquadBackEnd.Application.Dtos;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace GymSquadBackEnd.Application.Interfaces
{
    public interface ISolicitacaoService
    {
        IEnumerable<SolicitacaoDto> GetByGrupoId(int grupoId);

        SolicitacaoDto Post(SolicitacaoForm form);

        SolicitacaoDto AceitarSolicitacao(SolicitacaoForm form);

        SolicitacaoDto RecusarSolicitacao(SolicitacaoForm form);
    }
}
