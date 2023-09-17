﻿using EventPlanr.Application.Contracts;
using EventPlanr.Domain.Entities;
using Microsoft.EntityFrameworkCore;

namespace EventPlanr.Infrastructure.Persistance;

public class EventPlanrDbContext : DbContext, IApplicationDbContext
{
    public EventPlanrDbContext() { }
    public EventPlanrDbContext(DbContextOptions options) : base(options) { }

    public DbSet<EventEntity> Events => Set<EventEntity>();
    public DbSet<OrganizationEntity> Organizations => Set<OrganizationEntity>();
    public DbSet<NewsPostEntity> NewsPosts => Set<NewsPostEntity>();
    public DbSet<TicketEntity> Tickets => Set<TicketEntity>();
    public DbSet<SoldTicketEntity> SoldTickets => Set<SoldTicketEntity>();
    public DbSet<OrderEntity> Orders => Set<OrderEntity>();
    public DbSet<InvitationEntity> Inviations => Set<InvitationEntity>();

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        base.OnModelCreating(modelBuilder);
        modelBuilder.ApplyConfigurationsFromAssembly(typeof(EventPlanrDbContext).Assembly);
    }
}
