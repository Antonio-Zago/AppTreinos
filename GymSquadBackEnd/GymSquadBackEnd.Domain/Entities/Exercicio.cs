using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace GymSquadBackEnd.Domain.Entities
{
    public class Exercicio
    {
        public int Id { get; set; }

        [Required]
        [StringLength(80)]
        public string Nome { get; set; }

        public byte[] Foto { get; set; }
    }
}
