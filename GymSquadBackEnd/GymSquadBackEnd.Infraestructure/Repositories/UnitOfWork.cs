using GymSquadBackEnd.Domain.Interfaces;
using GymSquadBackEnd.Infraestructure.Context;
using Microsoft.EntityFrameworkCore.Storage;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace GymSquadBackEnd.Infraestructure.Repositories
{
    public class UnitOfWork : IUnitOfWork
    {
        private readonly AppDbContext _db;

        private IDbContextTransaction _dbTransaction;

        public UnitOfWork(AppDbContext db)
        {
            _db = db;
        }

        public void BeginTransaction()
        {
            _dbTransaction = _db.Database.BeginTransaction();
        }

        public void Commit()
        {
            _dbTransaction.Commit();
        }

        public void Dispose()
        {
            _dbTransaction?.Dispose();
        }

        public void Roolback()
        {
            _dbTransaction.Rollback();
        }
    }
}
