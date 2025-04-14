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
    public class DadosTreinoExercicioSeriesRepository : IDadosTreinoExercicioSeriesRepository
    {
        private readonly AppDbContext _appDbContext;

        public DadosTreinoExercicioSeriesRepository(AppDbContext appDbContext)
        {
            _appDbContext = appDbContext;
        }


        public DadosTreinoExerciciosSerie Post(DadosTreinoExerciciosSerie entidade)
        {
            _appDbContext.Dados_Treino_Exercicios_Series.Add(entidade);
            _appDbContext.SaveChanges();
            return entidade;
        }
    }
}
