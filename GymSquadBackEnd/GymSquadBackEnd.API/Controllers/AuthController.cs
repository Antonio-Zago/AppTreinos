using GymSquadBackEnd.Application.Dtos;
using GymSquadBackEnd.Application.Interfaces;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;
using System.Text;

namespace GymSquadBackEnd.API.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class AuthController : ControllerBase
    {
        private readonly ITokenService _tokenService;
        private readonly IConfiguration _config;
        private readonly IUsuarioService _usuarioService;

        public AuthController(ITokenService tokenService, IConfiguration config, IUsuarioService usuarioService)
        {
            _tokenService = tokenService;
            _config = config;
            _usuarioService = usuarioService;
        }


        [HttpPost]
        [Route("login")]
        public IActionResult Login([FromBody] UsuarioForm model)
        {
            var user = _usuarioService.FindByEmail(model.Email);

            if (user is not null && _usuarioService.CheckPassword(model.Senha, user.Senha))
            {

                var authClaims = new List<Claim>
                {
                    new Claim(ClaimTypes.Name, user.Nome),
                    new Claim(ClaimTypes.Email, user.Email),
                    new Claim(JwtRegisteredClaimNames.Jti, Guid.NewGuid().ToString()),
                };


                var token = _tokenService.GenerateAccessToken(authClaims,
                                                             _config);

                var refreshToken = _tokenService.GenerateRefreshToken();

                _ = int.TryParse(_config["JWT:RefreshTokenValidityInMinutes"],
                                   out int refreshTokenValidityInMinutes);

                user.RefreshTokenExpiryTime =
                                DateTime.Now.AddMinutes(refreshTokenValidityInMinutes);

                user.RefreshToken = refreshToken;

                _usuarioService.UpdateRefreshToken(user.Id, user);

                return Ok(new
                {
                    Token = new JwtSecurityTokenHandler().WriteToken(token),
                    RefreshToken = refreshToken,
                    Expiration = token.ValidTo,
                    Usuario = user.Nome,
                    Email = user.Email,
                    Id = user.Id
                });
            }
            return Unauthorized();
        }

        [HttpPost]
        [Route("register")]
        public ActionResult Register([FromBody] RegisterForm model)
        {
            var result = _usuarioService.Post(model);

            if (result == null)
            {
                return StatusCode(StatusCodes.Status500InternalServerError,
                       new { Status = "Error", Message = "User creation failed." });
            }

            return Ok(new { Status = "Success", Message = "User created successfully!" });

        }

        [HttpPost]
        [Route("refresh-token")]
        public IActionResult RefreshToken([FromBody] TokenForm tokenForm)
        {

            if (tokenForm is null)
            {
                return BadRequest("Invalid client request");
            }

            string? accessToken = tokenForm.AccessToken
                                  ?? throw new ArgumentNullException(nameof(tokenForm));

            string? refreshToken = tokenForm.RefreshToken
                                   ?? throw new ArgumentException(nameof(tokenForm));

            var principal = _tokenService.GetPrincipalFromExpiredToken(accessToken!, _config);

            if (principal == null)
            {
                return BadRequest("Invalid access token/refresh token");
            }
            string username = principal.Identity.Name;

            var user = _usuarioService.FindByNome(username!);

            if (user == null || user.RefreshToken != refreshToken
                             || user.RefreshTokenExpiryTime <= DateTime.Now)
            {
                return BadRequest("Invalid access token/refresh token");
            }

            var newAccessToken = _tokenService.GenerateAccessToken(
                                               principal.Claims.ToList(), _config);

            var newRefreshToken = _tokenService.GenerateRefreshToken();

            user.RefreshToken = newRefreshToken;

            _usuarioService.UpdateRefreshToken(user.Id, user);

            return new ObjectResult(new
            {
                token = new JwtSecurityTokenHandler().WriteToken(newAccessToken),
                refreshToken = newRefreshToken
            });
        }

        [Authorize]
        [HttpPost]
        [Route("revoke/{username}")]
        [Authorize(Policy = "ADMINEXCLUSIVO")]
        public IActionResult Revoke(string username)
        {
            var user = _usuarioService.FindByNome(username);

            if (user == null) return BadRequest("Invalid user name");

            user.RefreshToken = null;

            _usuarioService.UpdateRefreshToken(user.Id, user);

            return NoContent();
        }
    }
}
