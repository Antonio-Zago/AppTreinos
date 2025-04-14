using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace GymSquadBackEnd.Application.Dtos
{
    public class DadosTreinoExercicioDto
    {
        public int Id { get; set; }

        public int ExercicioId { get; set; }

        public List<DadosTreinoExercicioSerieDto> DadosTreinoExercicioSeries { get; set; }
    }
}
