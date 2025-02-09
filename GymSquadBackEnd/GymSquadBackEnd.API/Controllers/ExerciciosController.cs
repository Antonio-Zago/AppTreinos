using GymSquadBackEnd.Application.Dtos;
using GymSquadBackEnd.Application.Interfaces;
using GymSquadBackEnd.Domain.Entities;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace GymSquadBackEnd.API.Controllers
{
    [Route("[controller]")]
    [ApiController]
    public class ExerciciosController : ControllerBase
    {
        public IExerciciosService _exerciciosService { get; set; }

        public ExerciciosController(IExerciciosService exerciciosService)
        {
            _exerciciosService = exerciciosService;
        }

        [HttpGet]
        public ActionResult<List<Exercicio>> GetAll()
        {
            return Ok(_exerciciosService.GetAll());
        }

        [HttpPost]
        public ActionResult Post(ExercicioForm form)
        {

            _exerciciosService.Post(form);
            return Ok();
        }
    }
}
