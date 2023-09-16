using EventPlanr.Domain.Common;
using EventPlanr.Domain.Entities;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using Microsoft.EntityFrameworkCore.ValueGeneration;

namespace EventPlanr.Infrastructure.Persistance.Configuration;

public class OrderConfiguration : IEntityTypeConfiguration<Order>
{
    public void Configure(EntityTypeBuilder<Order> builder)
    {
        builder.ToTable("orders");

        builder.Property(o => o.Id)
            .HasValueGenerator<GuidValueGenerator>();
        builder.Property(o => o.CustomerUserId)
            .IsRequired();
        builder.Property(o => o.CustomerFirstName)
            .HasMaxLength(64)
            .IsRequired();
        builder.Property(o => o.CustomerLastName)
            .HasMaxLength(64)
            .IsRequired();
        builder.Property(o => o.Currency)
            .IsRequired();

        builder.OwnsOne(e => e.BillingAddress, address =>
        {
            address.Property(a => a.Country)
                .HasMaxLength(64)
                .IsRequired();
            address.Property(a => a.City)
                .HasMaxLength(64)
                .IsRequired();
            address.Property(a => a.ZipCode)
                .HasMaxLength(10)
                .IsRequired();
            address.Property(a => a.AddressLine)
                .HasMaxLength(256)
                .IsRequired();
        });
    }
}
