using GymSquadBackEnd.Domain.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace GymSquadBackEnd.Domain.Interfaces
{
    public interface ISolicitacaoRepository
    {
        IEnumerable<Solicitacoes> GetByGroupId(int groupId);

        void Post(Solicitacoes solicitacao);

        Solicitacoes GetByGroupIdAndUserId(int groupId, int usuarioId);

        Solicitacoes Update(Solicitacoes solicitacao);
    }
}
