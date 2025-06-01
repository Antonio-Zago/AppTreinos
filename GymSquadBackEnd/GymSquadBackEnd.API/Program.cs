using GymSquadBackEnd.Application.Interfaces;
using GymSquadBackEnd.Application.Services;
using GymSquadBackEnd.Domain.Interfaces;
using GymSquadBackEnd.Infraestructure.Context;
using GymSquadBackEnd.Infraestructure.Repositories;
using GymSquadBackEnd.CrossCutting.Ioc;
using Microsoft.EntityFrameworkCore;
using System;
using GymSquadBackEnd.Application.Middleware;

var builder = WebApplication.CreateBuilder(args);

// Configuração da URL de escuta para permitir conexões externas
builder.WebHost.ConfigureKestrel(serverOptions =>
{
    serverOptions.Listen(System.Net.IPAddress.Any, 7176, listenOptions =>
    {
        listenOptions.UseHttps();  // HTTPS
    });;  // Ou o IP da sua máquina
});

// Add services to the container.

builder.Services.AddControllers();
// Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

builder.Services.AddInfraestructure(builder.Configuration);

builder.Services.AddCors(options =>
{
    options.AddPolicy("AllowAll", builder =>
    {
        builder.AllowAnyOrigin()  // Permite qualquer origem
               .AllowAnyHeader()
               .AllowAnyMethod();
    });
});

var app = builder.Build();

app.UseCors("AllowAll");

// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI(); 
}

app.UseMiddleware<ExceptionMiddleware>();

app.UseHttpsRedirection();

app.UseAuthorization();

app.MapControllers();


app.Run();
