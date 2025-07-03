using GymSquadBackEnd.Domain.Entities;
using GymSquadBackEnd.Domain.Interfaces;
using GymSquadBackEnd.Infraestructure.Context;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace GymSquadBackEnd.Infraestructure.Repositories
{
    public class SolicitacaoRepository : ISolicitacaoRepository
    {
        private readonly AppDbContext _appDbContext;

        public SolicitacaoRepository(AppDbContext appDbContext)
        {
            _appDbContext = appDbContext;
        }
        public IEnumerable<Solicitacoes> GetByGroupId(int groupId)
        {
            return _appDbContext.Solicitacoes.Where(a => a.GrupoId == groupId).Include(a => a.Grupo).Include(a => a.Usuario);
        }

        public void Post(Solicitacoes solicitacao)
        {
            _appDbContext.Solicitacoes.Add(solicitacao);
            _appDbContext.SaveChanges();
        }

    }
}
