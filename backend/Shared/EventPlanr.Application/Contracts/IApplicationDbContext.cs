using EventPlanr.Domain.Entities;
using Microsoft.EntityFrameworkCore;

namespace EventPlanr.Application.Contracts;

public interface IApplicationDbContext
{
    DbSet<EventEntity> Events { get; }
    DbSet<OrganizationEntity> Organizations { get; }
    DbSet<NewsPostEntity> NewsPosts { get; }
    DbSet<TicketEntity> Tickets { get; }
    DbSet<SoldTicketEntity> SoldTickets { get; }
    DbSet<OrderEntity> Orders { get; }
    DbSet<InvitationEntity> Inviations { get; }

    Task<int> SaveChangesAsync(CancellationToken cancellationToken = default);
}
