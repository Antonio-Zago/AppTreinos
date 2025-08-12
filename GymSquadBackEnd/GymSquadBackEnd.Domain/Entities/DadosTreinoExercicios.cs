using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace GymSquadBackEnd.Domain.Entities
{
    public class DadosTreinoExercicios
    {
        public int Id { get; set; }

        [Column("DadoTreino")]
        public int DadosTreinoId { get; set; }

        public DadosTreino DadosTreino { get; set; }

        [Column("Exercicio")]
        public int ExercicioId { get; set; }

        public Exercicio Exercicio { get; set; }
    }
}
