using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace GymSquadBackEnd.Domain.Entities
{
    public class TreinoExercicio
    {

        public int Id { get; set; }

        [Column("exercicio")]
        public int ExercicioId { get; set; }

        public Exercicio Exercicio { get; set; }

        [Column("treino")]
        public int TreinoId { get; set; }

        public Treino Treino { get; set; }

    }
}
