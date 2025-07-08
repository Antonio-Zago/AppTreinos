using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace GymSquadBackEnd.Domain.Entities
{
    public class Solicitacoes
    {
        public int Id { get; set; }

        [Column("usuario")]
        public int UsuarioId { get; set; }

        public Usuario? Usuario { get; set; }

        [Column("grupo")]
        public int GrupoId { get; set; }

        public Grupo? Grupo { get; set; }

        public DateTime DataHora { get; set; }

        /*
         1 - cadastrada
         2 - aceita
         3 - recusada
         */
        public int Status { get; set; }
    }
}
