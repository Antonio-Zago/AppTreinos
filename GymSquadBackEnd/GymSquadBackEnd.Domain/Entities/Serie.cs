using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace GymSquadBackEnd.Domain.Entities
{
    public class Serie
    {
        public int Id { get; set; }

        [Column("TreinoExercicio")]
        public int TreinoExercicioId { get; set; }

        public TreinoExercicio TreinoExercicio { get; set; }

        public int Repeticoes { get; set; }

        public double Carga { get; set; }
    }
}
