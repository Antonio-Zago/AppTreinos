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
    public class DadosTreinoExerciciosRepository : IDadosTreinoExerciciosRepository
    {
        private readonly AppDbContext _appDbContext;

        public DadosTreinoExerciciosRepository(AppDbContext appDbContext)
        {
            _appDbContext = appDbContext;
        }


        public DadosTreinoExercicios Post(DadosTreinoExercicios entidade)
        {
            _appDbContext.Dados_Treino_Exercicios.Add(entidade);
            _appDbContext.SaveChanges();
            return entidade;
        }
    }
}
