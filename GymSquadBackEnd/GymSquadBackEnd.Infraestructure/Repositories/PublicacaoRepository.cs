using GymSquadBackEnd.Domain.Entities;
using GymSquadBackEnd.Domain.Interfaces;
using GymSquadBackEnd.Domain.Requests;
using GymSquadBackEnd.Domain.Responses;
using GymSquadBackEnd.Infraestructure.Context;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace GymSquadBackEnd.Infraestructure.Repositories
{
    public class PublicacaoRepository : IPublicacaoRepository
    {
        private readonly AppDbContext _appDbContext;
        public PublicacaoRepository(AppDbContext appDbContext)
        {
            _appDbContext = appDbContext;
        }

        public Publicacao Post(Publicacao entidade)
        {
            _appDbContext.Publicacoes.Add(entidade);
            _appDbContext.SaveChanges();
            return entidade;
        }

        public PagedBaseResponse<Publicacao> GetByCodigoGrupoPaged(int codigoGrupo, PagedBaseRequests request)
        {
            var publicacoes = _appDbContext.Publicacoes.Include(a => a.Usuario).Where(a => a.Grupo.Codigo == codigoGrupo).AsQueryable();

            return PagedBaseResponseHelper.GetResponse<PagedBaseResponse<Publicacao>, Publicacao>(publicacoes, request);
        }
    }
}
