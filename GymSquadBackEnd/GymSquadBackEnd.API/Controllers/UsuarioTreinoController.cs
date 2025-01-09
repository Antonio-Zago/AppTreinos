﻿using GymSquadBackEnd.Application.Dtos;
using GymSquadBackEnd.Application.Interfaces;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace GymSquadBackEnd.API.Controllers
{
    [Route("[controller]")]
    [ApiController]
    public class UsuarioTreinoController : ControllerBase
    {

        public IUsuarioTreinoService _service { get; set; }

        public UsuarioTreinoController(IUsuarioTreinoService service)
        {
            _service = service;
        }

        [Authorize]
        [HttpGet("{userId}")]
        public ActionResult<List<UsuarioTreinoDto>> GetByUserId(int userId)
        {
            var usuarioTreinoDtos = _service.getByUserId(userId);

            return Ok(usuarioTreinoDtos);
        }

        [Authorize]
        [HttpPost]
        public ActionResult<UsuarioTreinoDto> Post([FromBody] UsuarioTreinoForm form)
        {
            var usuarioTreinoDtos = _service.Post(form);

            return Ok(usuarioTreinoDtos);
        }
    }
}
