using GymSquadBackEnd.Application.Dtos;
using GymSquadBackEnd.Application.Interfaces;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace GymSquadBackEnd.API.Controllers
{
    [Route("[controller]")]
    [ApiController]
    public class SolicitacoesController : ControllerBase
    {
        public ISolicitacaoService _service { get; set; }

        public SolicitacoesController(ISolicitacaoService service)
        {
            _service = service;
        }

        [Authorize]
        [HttpGet("GetByGrupoId/{grupoId}")]
        public ActionResult<List<SolicitacaoDto>> GetByGrupoId(int grupoId)
        {
            var dtos = _service.GetByGrupoId(grupoId);

            return Ok(dtos);
        }

        [Authorize]
        [HttpPost]
        public ActionResult<SolicitacaoDto> Post(SolicitacaoForm form)
        {
            var dto = _service.Post(form);

            return Ok(dto);
        }

        [Authorize]
        [HttpPost("AceitarSolicitacao")]
        public ActionResult<SolicitacaoDto> AceitarSolicitacao(SolicitacaoForm form)
        {
            var dto = _service.AceitarSolicitacao(form);

            return Ok(dto);
        }

        [Authorize]
        [HttpPut("RecusarSolicitacao")]
        public ActionResult<SolicitacaoDto> RecusarSolicitacao(SolicitacaoForm form)
        {
            var dto = _service.RecusarSolicitacao(form);

            return Ok(dto);
        }
    }
}
