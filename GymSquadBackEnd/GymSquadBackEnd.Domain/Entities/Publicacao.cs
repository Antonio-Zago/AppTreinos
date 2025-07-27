using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace GymSquadBackEnd.Domain.Entities
{
    public class Publicacao
    {
        public int Id { get; set; }

        public string Titulo { get; set; }

        public string Descricao { get; set; }

        public byte[]? Foto { get; set; }

        [Column("grupo")]
        public int GrupoId { get; set; }
        public Grupo Grupo { get; set; }

        [Column("usuario")]
        public int UsuarioId { get; set; }
        public Usuario Usuario { get; set; }

        public DateTime DataHora { get; set; }
    }
}
