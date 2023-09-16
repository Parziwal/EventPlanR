using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using EventPlanr.Domain.Entities;
using Microsoft.EntityFrameworkCore.ValueGeneration;

namespace EventPlanr.Infrastructure.Persistance.Configuration;

public class EventConfiguration : IEntityTypeConfiguration<Event>
{
    public void Configure(EntityTypeBuilder<Event> builder)
    {
        builder.ToTable("events");
        
        builder.Property(e => e.Id)
            .HasValueGenerator<GuidValueGenerator>();
        builder.Property(e => e.Name)
            .IsRequired()
            .HasMaxLength(64);
        builder.Property(e => e.Category)
            .IsRequired();
        builder.Property(e => e.FromDate)
            .IsRequired();
        builder.Property(e => e.ToDate)
            .IsRequired();
        builder.Property(e => e.Venue)
            .HasMaxLength(64)
            .IsRequired();
        builder.Property(e => e.Language)
            .IsRequired();
        builder.Property(e => e.Currency)
            .IsRequired();
        builder.Property(e => e.IsPrivate)
            .IsRequired();
        builder.Property(e => e.IsPublished)
            .IsRequired();

        builder.OwnsOne(e => e.Address, address =>
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

        var coordinates = builder.OwnsOne(e => e.Coordinates, coordinates =>
        {
            coordinates.Property(c => c.Latitude)
                .IsRequired();
            coordinates.Property(c => c.Longitude)
                .IsRequired();
        });

        builder.HasOne(e => e.Organization)
            .WithMany(o => o.Events)
            .HasForeignKey(e => e.OrganizationId)
            .IsRequired();
    }
}
