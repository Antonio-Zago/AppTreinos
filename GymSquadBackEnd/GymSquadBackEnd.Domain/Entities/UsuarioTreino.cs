using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace GymSquadBackEnd.Domain.Entities
{
    public class UsuarioTreino
    {
        public int UsuarioId { get; set; }

        public Usuario Usuario { get; set; }

        public int TreinoId { get; set; }

        public Treino Treino { get; set; }
    }
}
