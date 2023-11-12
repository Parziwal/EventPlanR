using EventPlanr.Domain.Entities;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using Microsoft.EntityFrameworkCore.ValueGeneration;

namespace EventPlanr.Infrastructure.Persistance.Configuration;

public class SoldTicketConfiguration : IEntityTypeConfiguration<SoldTicketEntity>
{
    public void Configure(EntityTypeBuilder<SoldTicketEntity> builder)
    {
        builder.ToTable("sold_tickets");

        builder.Property(st => st.Id)
            .HasValueGenerator<GuidValueGenerator>();
        builder.Property(st => st.UserFirstName)
            .HasMaxLength(64)
            .IsRequired();
        builder.Property(st => st.UserLastName)
            .HasMaxLength(64)
            .IsRequired();
        builder.Property(st => st.Price)
            .IsRequired();

        builder.HasOne(st => st.Ticket)
            .WithMany(st => st.SoldTickets)
            .HasForeignKey(st => st.TicketId)
            .IsRequired(false);
        builder.HasOne(st => st.Order)
            .WithMany(o => o.SoldTickets)
            .HasForeignKey(st => st.OrderId)
            .IsRequired();
    }
}
