using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace GymSquadBackEnd.Application.Dtos
{
    public class DadosTreinoExercicioSerieDto
    {
        public int Id { get; set; }

        public int Repeticoes { get; set; }

        public double Carga { get; set; }
    }
}
