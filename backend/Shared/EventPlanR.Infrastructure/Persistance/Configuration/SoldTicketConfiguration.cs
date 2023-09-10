using EventPlanr.Domain.Entities;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using Microsoft.EntityFrameworkCore.ValueGeneration;

namespace EventPlanr.Infrastructure.Persistance.Configuration;

public class SoldTicketConfiguration : IEntityTypeConfiguration<SoldTicket>
{
    public void Configure(EntityTypeBuilder<SoldTicket> builder)
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
    }
}
