using GymSquadBackEnd.Domain.Entities;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace GymSquadBackEnd.Application.Dtos
{
    public class UsuarioGrupoDto
    {
        public int UsuarioId { get; set; }

        public int GrupoId { get; set; }

        public bool EhAdmin { get; set; }

        public string Nome { get; set; }
    }
}
