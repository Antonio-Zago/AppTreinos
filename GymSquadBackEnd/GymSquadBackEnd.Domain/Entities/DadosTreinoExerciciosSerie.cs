using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace GymSquadBackEnd.Domain.Entities
{
    public class DadosTreinoExerciciosSerie
    {
        public int Id { get; set; }

        [Column("DadoTreinoExercicio")]
        public int DadoTreinoExercicioId { get; set; }

        public DadosTreinoExercicios DadoTreinoExercicio { get; set; }

        public int Repeticoes { get; set; }

        public double Carga { get; set; }
    }
}
