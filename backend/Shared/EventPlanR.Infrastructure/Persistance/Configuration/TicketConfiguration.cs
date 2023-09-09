using EventPlanr.Domain.Entities;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using Microsoft.EntityFrameworkCore.ValueGeneration;

namespace EventPlanr.Infrastructure.Persistance.Configuration;

public class TicketConfiguration : IEntityTypeConfiguration<Ticket>
{
    public void Configure(EntityTypeBuilder<Ticket> builder)
    {
        builder.ToTable("tickets");

        builder.Property(t => t.Id)
            .HasValueGenerator<GuidValueGenerator>();
        builder.Property(t => t.Name)
            .HasMaxLength(128)
            .IsRequired();
        builder.Property(t => t.Price)
            .IsRequired();

        builder.HasOne(t => t.Event)
            .WithMany(e => e.Tickets)
            .HasForeignKey(t => t.EventId)
            .IsRequired();
        builder.HasOne(t => t.SoldTicket)
            .WithOne(st => st.Ticket)
            .HasForeignKey<SoldTicket>(st => st.TickerId)
            .IsRequired();
    }
}
