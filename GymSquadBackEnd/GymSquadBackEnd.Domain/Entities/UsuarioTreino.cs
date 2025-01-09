using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Text.Json.Serialization;
using System.Threading.Tasks;

namespace GymSquadBackEnd.Domain.Entities
{
    public class UsuarioTreino
    {
        [Column("usuario")]
        public int UsuarioId { get; set; }

        public Usuario? Usuario { get; set; }

        [Column("treino")]
        public int TreinoId { get; set; }

        public Treino? Treino { get; set; }
    }
}
