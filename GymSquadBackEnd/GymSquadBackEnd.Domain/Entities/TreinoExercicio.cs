using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace GymSquadBackEnd.Domain.Entities
{
    public class TreinoExercicio
    {

        public int Id { get; set; }

        public int ExercicioId { get; set; }

        public Exercicio Exercicio { get; set; }

        public int TreinoId { get; set; }

        public Treino Treino { get; set; }

        public int Repeticoes { get; set; }

        public double Carga { get; set; }

        public int Series { get; set; }
    }
}
