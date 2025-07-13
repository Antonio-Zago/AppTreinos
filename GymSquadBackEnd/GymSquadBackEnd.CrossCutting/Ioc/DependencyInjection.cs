using GymSquadBackEnd.Application.Interfaces;
using GymSquadBackEnd.Application.Services;
using GymSquadBackEnd.Domain.Interfaces;
using GymSquadBackEnd.Infraestructure.Context;
using GymSquadBackEnd.Infraestructure.Repositories;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.IdentityModel.Tokens;
using Sqids;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace GymSquadBackEnd.CrossCutting.Ioc
{
    public static class DependencyInjection
    {
        public static IServiceCollection AddInfraestructure(this IServiceCollection services, ConfigurationManager configuration)
        {
            services.AddAuthorization();

            var secretKey = configuration["JWT:SecretKey"]
                   ?? throw new ArgumentException("Invalid secret key!!");

            var mySqlConnection = configuration.GetConnectionString("DefaultConnection");

            services.AddAuthentication(options =>
            {
                options.DefaultAuthenticateScheme = JwtBearerDefaults.AuthenticationScheme;
                options.DefaultChallengeScheme = JwtBearerDefaults.AuthenticationScheme;
            }).AddJwtBearer(options =>
            {
                options.SaveToken = true;
                options.RequireHttpsMetadata = false;
                options.TokenValidationParameters = new TokenValidationParameters()
                {
                    ValidateIssuer = true,
                    ValidateAudience = true,
                    ValidateLifetime = true,
                    ValidateIssuerSigningKey = true,
                    ClockSkew = TimeSpan.Zero,
                    ValidAudience = configuration["JWT:ValidAudience"],
                    ValidIssuer = configuration["JWT:ValidIssuer"],
                    IssuerSigningKey = new SymmetricSecurityKey(
                                       Encoding.UTF8.GetBytes(secretKey))
                };
            });


            services.AddDbContext<AppDbContext>(options => options.UseMySql(mySqlConnection,
                                                                        ServerVersion.AutoDetect(mySqlConnection)));

            services.AddScoped<IExerciciosRepository, ExerciciosRepository>();
            services.AddScoped<IExerciciosService, ExerciciosService>();
            services.AddScoped<ITokenService, TokenService>();
            services.AddScoped<IUsuarioRepository, UsuarioRepository>();
            services.AddScoped<IUsuarioService, UsuarioService>();
            services.AddScoped<IUsuarioTreinoService, UsuarioTreinoService>();
            services.AddScoped<IUsuarioTreinoRepository, UsuarioTreinoRepository>();
            services.AddScoped<ITreinoExercicioRepository, TreinoExercicioRepository>();
            services.AddScoped<ITreinoRepository, TreinoRepository>();
            services.AddScoped<ISerieRepository, SerieRepository>();
            services.AddScoped<IDadosTreinoService, DadosTreinoService>();
            services.AddScoped<IDadosTreinoRepository, DadosTreinoRepository>();
            services.AddScoped<IDadosTreinoExerciciosRepository, DadosTreinoExerciciosRepository>();
            services.AddScoped<IDadosTreinoExercicioSeriesRepository, DadosTreinoExercicioSeriesRepository>();
            services.AddScoped<IUsuarioGrupoService, UsuarioGrupoService>();
            services.AddScoped<IUsuarioGrupoRepository, UsuarioGrupoRepository>();
            services.AddScoped<IGrupoRepository, GrupoRepository>();
            services.AddScoped<ISolicitacaoRepository, SolicitacaoRepository>();
            services.AddScoped<ISolicitacaoService, SolicitacaoService>();
            services.AddSingleton<SqidsEncoder<int>>();
            services.AddScoped<IUnitOfWork, UnitOfWork>();
            services.AddScoped<IGrupoService, GrupoService>();
            services.AddTransient<IQueryRepository, QueryRepository>();

            return services;
        }
    }
}
