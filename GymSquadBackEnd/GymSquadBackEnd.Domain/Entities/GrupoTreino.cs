using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace GymSquadBackEnd.Domain.Entities
{
    public class GrupoTreino
    {
        [Column("treino")]
        public int TreinoId { get; set; }

        public Treino? Treino { get; set; }

        [Column("grupo")]
        public int GrupoId { get; set; }
    }
}
