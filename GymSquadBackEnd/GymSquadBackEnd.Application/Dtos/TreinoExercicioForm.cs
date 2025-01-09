using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace GymSquadBackEnd.Application.Dtos
{
    public class TreinoExercicioForm
    {
        public int ExercicioId { get; set; }

        public List<SeriesForm> Series { get; set; }
    }
}
