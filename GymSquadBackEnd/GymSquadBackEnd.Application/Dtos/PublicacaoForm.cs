using GymSquadBackEnd.Domain.Entities;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace GymSquadBackEnd.Application.Dtos
{
    public class PublicacaoForm
    {
        public string Titulo { get; set; }

        public string Descricao { get; set; }

        public byte[]? Foto { get; set; }

        public int CodigoGrupo { get; set; }

        public int UsuarioId { get; set; }
    }
}
