using GymSquadBackEnd.Domain.Entities;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace GymSquadBackEnd.Infraestructure.Context
{
    public class AppDbContext : DbContext
    {
        public AppDbContext(DbContextOptions<AppDbContext> options) : base(options)
        {

        }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<UsuarioTreino>()
                .HasKey(ea => new { ea.UsuarioId, ea.TreinoId });  // Chave primária composta

            base.OnModelCreating(modelBuilder);
        }

        public DbSet<Exercicio>? Exercicios { get; set; }

        public DbSet<Treino>? Treinos { get; set; }

        public DbSet<TreinoExercicio>? Treinos_Exercicios { get; set; }

        public DbSet<Usuario>? Usuarios { get; set; }

        public DbSet<UsuarioTreino> Usuarios_Treinos { get; set; }

        public DbSet<Serie> Series { get; set; }

    }
}
