using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using EventPlanr.Domain.Entities;
using Microsoft.EntityFrameworkCore.ValueGeneration;
using System.Reflection.Metadata;

namespace EventPlanr.Infrastructure.Persistance.Configuration;

public class EventConfiguration : IEntityTypeConfiguration<EventEntity>
{
    public void Configure(EntityTypeBuilder<EventEntity> builder)
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
        builder.Property(e => e.Currency)
            .IsRequired();
        builder.Property(e => e.IsPrivate)
            .IsRequired();
        builder.Property(e => e.IsPublished)
            .IsRequired();
        builder.Property(e => e.Coordinate)
            .HasColumnType("geography (point)")
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

        builder.HasOne(e => e.Organization)
            .WithMany(o => o.Events)
            .HasForeignKey(e => e.OrganizationId)
            .IsRequired(false);

        builder.HasOne(e => e.Chat)
            .WithOne(c => c.Event)
            .HasForeignKey<EventEntity>(e => e.ChatId)
            .IsRequired();

        builder.HasQueryFilter(x => x.IsDeleted == false);
    }
}
