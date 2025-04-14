using GymSquadBackEnd.Domain.Entities;
using GymSquadBackEnd.Domain.Interfaces;
using GymSquadBackEnd.Infraestructure.Context;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace GymSquadBackEnd.Infraestructure.Repositories
{
    public class DadosTreinoRepository : IDadosTreinoRepository
    {
        private readonly AppDbContext _appDbContext;

        public DadosTreinoRepository(AppDbContext appDbContext)
        {
            _appDbContext = appDbContext;
        }

       
        public DadosTreino Post(DadosTreino entidade)
        {
            _appDbContext.Dados_Treino.Add(entidade);
            _appDbContext.SaveChanges();
            return entidade;
        }
    }
}
