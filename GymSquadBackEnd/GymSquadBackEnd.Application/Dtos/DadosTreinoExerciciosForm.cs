using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace GymSquadBackEnd.Application.Dtos
{
    public class DadosTreinoExerciciosForm
    {
        public int ExercicioId { get; set; }

        public List<DadosTreinoExercicioSerieForm> DadosTreinoExercicioSeries { get; set; }
    }
}
