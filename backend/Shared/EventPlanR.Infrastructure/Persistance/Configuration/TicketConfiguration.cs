using EventPlanr.Domain.Entities;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using Microsoft.EntityFrameworkCore.ValueGeneration;

namespace EventPlanr.Infrastructure.Persistance.Configuration;

public class TicketConfiguration : IEntityTypeConfiguration<TicketEntity>
{
    public void Configure(EntityTypeBuilder<TicketEntity> builder)
    {
        builder.ToTable("tickets");

        builder.Property(t => t.Id)
            .HasValueGenerator<GuidValueGenerator>();
        builder.Property(t => t.Name)
            .HasMaxLength(64)
            .IsRequired();
        builder.Property(t => t.Description)
            .HasMaxLength(256);
        builder.Property(t => t.Price)
            .IsRequired();
        builder.Property(t => t.Count)
            .IsRequired();
        builder.Property(t => t.RemainingCount)
            .IsRequired();
        builder.Property(t => t.SaleStarts)
            .IsRequired();
        builder.Property(t => t.SaleEnds)
            .IsRequired();

        builder.HasOne(t => t.Event)
            .WithMany(e => e.Tickets)
            .HasForeignKey(t => t.EventId)
            .IsRequired();
    }
}
