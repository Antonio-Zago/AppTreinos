﻿using GymSquadBackEnd.Domain.Entities;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace GymSquadBackEnd.Application.Dtos
{
    public class SolicitacaoDto
    {
        public int UsuarioId { get; set; }

        public string UsuarioNome { get; set; }

        public int GrupoId { get; set; }

        public DateTime DataHora { get; set; }

        public int Status { get; set; }
    }
}
